class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create_or_sign_in]
  skip_before_action :ensure_site_role_present, only: [:create_or_sign_in, :show_self, :add_site_role]
  before_action :ensure_site_admin, only: [:admin_add_site_role]

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

  def show_self
    render json: current_user.to_json(include: [:site_role]), status: :ok
  end

  def add_site_role
    site_role_id = params[:site]
    if SiteRole.find(params[:site_role_id]).name == 'admin'
      render json: {message: "Cannot make yourself an admin. Only existing admins can make others an admin"}, status: :bad_request
      return
    end
    if site_role_id
      render json: {message: "user_id and site_role_id are both required"}, status: :bad_request
      return
    end
    assign_site_role(current_user, params[:site_role_id])
  end

  def admin_add_site_role
    user_id = params[:user_id]
    site_role_id = params[:site_role_id]
    unless user_id && site_role_id
      render json: {message: "user_id and site_role_id are both required"}, status: :bad_request
      return
    end

    user = User.find(user_id)
    assign_site_role(user, site_role_id)
  end

  private

  def create_user_params
    params.permit(:idtoken)
  end

  # user instance to assign the site_role to
  def assign_site_role(user, site_role_id)
    if user.site_role
      render json: {message: "User is already #{user.site_role.name}"}, status: :ok
    else
      site_role = SiteRole.find(params[:site_role_id])
      user.site_role = site_role
      user.save
      render json: {message: "User added as #{user.site_role.name}"}, status: :created
    end
  end
end
