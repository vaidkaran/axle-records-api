require 'httparty'
require 'jwt'
require 'helpers/current_user'
require 'helpers/application_controller_helper'
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ApplicationControllerHelper

  before_action :authenticate_user!
  before_action :ensure_site_role_present

  protected

  def set_current_user(user)
    CurrentUser.set(user)
  end

  def current_user
    CurrentUser.get
  end

  def render_unauthorized_with_msg(err)
    render json: {error: err}, status: :unauthorized
  end

  def verify_token(idtoken)
    @auth_errors = []
    # TODO: this should not be used here
    aud = 'axle-records-firebase'
    token_issuer = 'https://securetoken.google.com/axle-records-firebase'

    if idtoken.present?
      if (Rails.env.development? || Rails.env.test?) && params[:test_mode]=='true'
        decoded_token = JWT.decode(idtoken, nil, false)
        return get_user_params_from_decoded_token(decoded_token)
      end
      kid = JWT.decode(idtoken, nil, false)[1]['kid']

      # TODO: Use the value of max-age in the Cache-Control header of the response from that endpoint to know when to refresh the public keys.
      # url = 'https://www.googleapis.com/oauth2/v1/certs'
      url = 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'
      cert_string = HTTParty.get(url)[kid]
      cert = OpenSSL::X509::Certificate.new(cert_string)

      begin
        decoded_token = JWT.decode(idtoken, cert.public_key, true,
          { algorithm: 'RS256',
            :verify_iat => true,
            :verify_aud => true, :aud => aud,
            :verify_iss => true, :iss => token_issuer })

      user_params = get_user_params_from_decoded_token(decoded_token)

      # TODO: do we need this info? this isn't present in decoded token
      # but can be passed from the google info from front end
      # user_params[:given_name] = decoded_token['given_name']
      # user_params[:family_name] = decoded_token['family_name']
      # user_params[:locale] = decoded_token['locale']
      return user_params
        
      rescue JWT::ExpiredSignature
        # Handle Expiration Time Claim: bad 'exp'
        @auth_errors.push "Invalid access token. 'Expiration time' (exp) must be in the future."
        return nil
      rescue JWT::InvalidIatError
        # Handle Issued At Claim: bad 'iat'
        @auth_errors.push "Invalid access token. 'Issued-at time' (iat) must be in the past."
        return nil
      rescue JWT::InvalidAudError
        # Handle Audience Claim: bad 'aud'
        @auth_errors.push "Invalid access token. 'Audience' (aud) must be your Firebase project ID, the unique identifier for your Firebase project."
        return nil
      rescue JWT::InvalidIssuerError
        # Handle Issuer Claim: bad 'iss'
        @auth_errors.push "Invalid access token. Invalid 'Issuer'"
        return nil
      rescue JWT::VerificationError
        # Handle Signature verification failed
        @auth_errors.push "Invalid access token. Signature verification failed."
        return nil
      end
    else
      @auth_errors.push "Requires Authorization"
      return nil
    end
  end

  def authenticate_user!
    user_params = verify_token(request.headers['Authorization']) # will set @auth_errors if any
    if user_params and user_params[:uid]
      user = User.find_by(uid: user_params[:uid])
      if user
        set_current_user(user)
      else
        return render_unauthorized_with_msg('User not found in db')
      end
    else
      return render_unauthorized_with_msg(@auth_errors)
    end
  end


  def ensure_site_role_present
    if current_user.site_roles.empty?
      render json: {error: 'Site role missing'}, status: :forbidden
    end
  end

  def ensure_site_admin
    unless(current_user.site_roles.include? SiteRole.find_by(name: :admin))
      render json: {error: 'Only site admins can perform this operation'}, status: :forbidden
    end
  end

  def ensure_customer
    unless(current_user.site_roles.include? SiteRole.find_by(name: :customer))
      render json: {error: 'Only customers can perform this operation'}, status: :forbidden
    end
  end

  def ensure_vendor
    unless(current_user.site_roles.include? SiteRole.find_by(name: :vendor))
      render json: {error: 'Only vendors can perform this operation'}, status: :forbidden
    end
  end

  def ensure_shop_admin(shop_id)
    is_shop_admin = current_user.vendor_shop_roles.where(shop_id: shop_id)
                                              .where(vendor_role_id: VendorRole.find_by(name: :admin).id)
                                              .exists?
    unless(is_shop_admin)
      render json: {error: 'Only shop admins can perform this operation'}, status: :forbidden
    end
  end

  def ensure_shop_member(shop_id)
    vendor_for_shop = current_user.vendor_shop_roles.where(shop_id: shop_id)
                                              .exists?
    unless(vendor_for_shop)
      render json: {error: 'Only vendors associated with this shop can perform this operation'}, status: :forbidden
    end
  end

  def ensure_shop_member_from_jobsheet(jobsheet_id)
    jobsheet = Jobsheet.find(jobsheet_id)
    ensure_shop_member(jobsheet.shop_id)
  end

end
