require 'httparty'
require 'jwt'
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authenticate_user!, except: :google_sign_in
  # before_action :ensure_site_role_present, unless: :oauth_user_new_or_update, except: :google_sign_in
  before_action :authenticate_user!

  protected

  def current_user
    @current_user || nil
  end

  def render_unauthorized_with_msg(err_msg)
    render json: {error: err_msg}, status: :unauthorized
  end

  # TODO: refactor to accomodate for other auth providers as well.
  def authenticate_user!
    # TODO: this should not be defined here
    google_client_id = '97966421563-vbau4nupvdunk6kpvkjbuime02f8hf4e.apps.googleusercontent.com'
    token_issuer = 'https://accounts.google.com'

    idtoken = request.headers['Authorization']
    if idtoken.present?
      puts "----->>> #{idtoken}"
      # decode and verify the token
      decoded_token = JWT.decode(idtoken, nil, false)
      kid = decoded_token[1]['kid']

      # TODO: Use the value of max-age in the Cache-Control header of the response from that endpoint to know when to refresh the public keys.
      url = 'https://www.googleapis.com/oauth2/v1/certs'
      cert_string = HTTParty.get(url)[kid]
      cert = OpenSSL::X509::Certificate.new(cert_string)
      puts decoded_token

      begin
        JWT.decode(idtoken, cert.public_key, true,
          { algorithm: 'RS256',
            :verify_iat => true,
            :verify_aud => true, :aud => google_client_id,
            :verify_iss => true, :iss => token_issuer })
      rescue JWT::ExpiredSignature
        # Handle Expiration Time Claim: bad 'exp'
        err_msg = "Invalid access token. 'Expiration time' (exp) must be in the future."
        return render_unauthorized_with_msg(err_msg)
      rescue JWT::InvalidIatError
        # Handle Issued At Claim: bad 'iat'
        err_msg = "Invalid access token. 'Issued-at time' (iat) must be in the past."
        return render_unauthorized_with_msg(err_msg)
      rescue JWT::InvalidAudError
        # Handle Audience Claim: bad 'aud'
        err_msg = "Invalid access token. 'Audience' (aud) must be your Firebase project ID, the unique identifier for your Firebase project."
        return render_unauthorized_with_msg(err_msg)
      rescue JWT::InvalidIssuerError
        # Handle Issuer Claim: bad 'iss'
        err_msg = "Invalid access token. Invalid 'Issuer'"
        return render_unauthorized_with_msg(err_msg)
      rescue JWT::VerificationError
        # Handle Signature verification failed
        err_msg = "Invalid access token. Signature verification failed."
        return render_unauthorized_with_msg(err_msg)
      end

      # take the uid/sub and search for the user in db, if not create one 
      user_params = {}
      user_params[:provider] = decoded_token[:iss]
      user_params[:uid] = decoded_token[:sub]
      user_params[:email] = decoded_token[:email]
      user_params[:name] = decoded_token[:name]
      user_params[:picture] = decoded_token[:picture]
      user_params[:given_name] = decoded_token[:given_name]
      user_params[:family_name] = decoded_token[:family_name]
      user_params[:locale] = decoded_token[:locale]

      user = User.find_by(uid: user_params[:uid)
      if user
        @current_user = user
      else
        @current_user = User.create!(user_params)
      end

    else
      head :unauthorized and return
    end
  end
 

  # def ensure_site_role_present
  #   if current_user.site_roles.empty?
  #     render json: {error: 'Site role missing'}, status: :forbidden
  #   end
  # end

  # def ensure_site_admin
  #   unless(current_user.site_roles.include? SiteRole.find_by(name: :admin))
  #     render json: {error: 'Only site admins can perform this operation'}, status: :forbidden
  #   end
  # end

  # def ensure_customer
  #   unless(current_user.site_roles.include? SiteRole.find_by(name: :customer))
  #     render json: {error: 'Only customers can perform this operation'}, status: :forbidden
  #   end
  # end

  # def ensure_vendor
  #   unless(current_user.site_roles.include? SiteRole.find_by(name: :vendor))
  #     render json: {error: 'Only vendors can perform this operation'}, status: :forbidden
  #   end
  # end

  # def ensure_shop_admin(shop_id)
  #   is_shop_admin = current_user.vendor_shop_roles.where(shop_id: shop_id)
  #                                             .where(vendor_role_id: VendorRole.find_by(name: :admin).id)
  #                                             .exists?
  #   unless(is_shop_admin)
  #     render json: {error: 'Only shop admins can perform this operation'}, status: :forbidden
  #   end
  # end

  # def ensure_shop_member(shop_id)
  #   vendor_for_shop = current_user.vendor_shop_roles.where(shop_id: shop_id)
  #                                             .exists?
  #   unless(vendor_for_shop)
  #     render json: {error: 'Only vendors associated with this shop can perform this operation'}, status: :forbidden
  #   end
  # end

  # def ensure_shop_member_from_jobsheet(jobsheet_id)
  #   jobsheet = Jobsheet.find(jobsheet_id)
  #   ensure_shop_member(jobsheet.shop_id)
  # end

end
