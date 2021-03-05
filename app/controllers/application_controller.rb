class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:google_sign_in, :sign_in]
  before_action :ensure_site_role_present, unless: :oauth_user_new_or_update, except: [:google_sign_in, :sign_in]
  before_action :disable_omniauth_mock, if: -> {Rails.env.development? || Rails.env.test?}, except: :google_sign_in


  protected

  def disable_omniauth_mock
    OmniAuth.config.test_mode = false
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :current_password])
  end

  def ensure_site_role_present
    if current_user.site_roles.empty?
      render json: {error: 'Site role missing'}, status: :forbidden
    end
  end

  def user_update_call
    if(params[:controller]=='devise_token_auth/registrations' && params[:action]=='update')
      return true
    else
      return false
    end
  end

  def oauth_user_new_or_update
    if((params[:controller]=='user_site_roles' && params[:action]=='add_role') ||
       (params[:controller]=='overrides/omniauth_callbacks' && params[:action]=='redirect_callbacks') ||
       (params[:controller]=='overrides/omniauth_callbacks' && params[:action]=='omniauth_success') ||
       (params[:controller]=='overrides/omniauth_callbacks' && params[:action]=='omniauth_failure'))
      return true
    else
      return false
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
