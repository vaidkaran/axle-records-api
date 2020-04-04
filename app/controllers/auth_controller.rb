class AuthController < ApplicationController
  def google_sign_in
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, {:uid => params[:uid], info: {:email => params[:email]}})

    redirect_to '/auth/google_oauth2' and return
  end
end
