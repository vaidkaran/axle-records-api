class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

	def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:site_role_id, :email, :password) }
			#devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
	end
end
