# This solution found here:
# https://github.com/lynndylanhurley/devise_token_auth/issues/1020
#
# app/controllers/overrides/omniauth_callbacks_controller.rb
module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
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
  end
end
