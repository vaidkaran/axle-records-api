class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create_or_sign_in]
  skip_before_action :ensure_site_role_present, only: [:create_or_sign_in]

  def create_or_sign_in
    user_params = verify_token(create_user_params[:idtoken]) # will set @auth_errors if any
    if user_params and user_params[:uid]
      user = User.find_by(uid: user_params[:uid])
      if user
        render json: user.to_json(include: [:site_roles]), status: :ok
      else
        user = User.create!(user_params)
        render json: user.to_json(include: [:site_roles]), status: :created
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
