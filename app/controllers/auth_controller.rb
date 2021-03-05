class AuthController < ApplicationController
  include ActionController::Cookies
  def google_sign_in
    unique_string = Time.now.strftime("%y%d%m%d%H%M%6N")
    email_prefix = params[:email_prefix] || 'test'
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2,
                             {uid: unique_string,
                              info: {email: "#{email_prefix}_#{unique_string}@test.com",
                                     name: 'Test User'}})

    redirect_to '/auth/google_oauth2' and return
  end

  def sign_in
    cookies[:app_id] = params[:app_id]
    redirect_to '/auth/google_oauth2'
  end
end
