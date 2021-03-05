# This solution found here:
# https://github.com/lynndylanhurley/devise_token_auth/issues/1020
#
# app/controllers/overrides/omniauth_callbacks_controller.rb
module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    include ActionController::Cookies
    skip_before_action :authenticate_user!, only: [:redirect_callbacks, :omniauth_success, :omniauth_failure]
    after_action :update_auth_header

    def assign_provider_attrs(user, auth_hash)
      all_attrs = auth_hash["info"].slice(*user.attributes.keys)
      orig_val = ActionController::Parameters.permit_all_parameters
      ActionController::Parameters.permit_all_parameters = true
      permitted_attrs = ActionController::Parameters.new(all_attrs)
      permitted_attrs.permit({})
      user.assign_attributes(permitted_attrs)
      ActionController::Parameters.permit_all_parameters = orig_val
      user
    end

    def render_data_or_redirect(message, data, user_data = {})
      if cookies[:app_id]==='react_native' && message==='deliverCredentials'
        redirect_to "exp://my-app?auth_token=#{@auth_params[:auth_token]}&client_id=#{@auth_params[:client_id]}&
                      uid=#{@auth_params[:uid]}&expiry=#{@auth_params[:expiry]}"
      else
        super(message, data, user_data = {})
      end
    end
  end
end
