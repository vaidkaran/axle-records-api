class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :ensure_site_role_present, unless: :oauth_user_new_or_update


  protected

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
end
