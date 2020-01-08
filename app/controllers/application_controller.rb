class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :ensure_site_role_present, unless: :user_update_call


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:site_role_id, :password, :current_password])
  end

  def ensure_site_role_present
    if current_user.site_role.nil?
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

  def ensure_site_admin
    unless(current_user.site_role.name === 'admin')
      render json: {error: 'Only site admins can perform this operation'}, status: :forbidden
    end
  end
end
