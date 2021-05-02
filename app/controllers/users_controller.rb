class UsersController < ApplicationController
  def create_or_sign_in
    # TODO: see if @current_user is accessible here. We might not have to create the current_user method
    user_params = verify_token(create_user_params[:idtoken]) # will set @auth_errors if any
    if user_params and user_params[:uid]
      user = User.find_by(uid: user_params[:uid])
      if user
        @current_user = user
        head :ok
      else
        User.create!(create_user_params)
        head :created
      end
    else
      return render_unauthorized_with_msg(@auth_errors)
    end
  end




  private

  def create_user_params
    params.permit(:idtoken)
  end
end
