class UserSiteRolesController < ApplicationController
  def add_role
    site_role = SiteRole.find(params[:site_role_id])

    if (!params[:user_id].nil?)
      if (current_user_is_admin)
        user = User.find(params[:user_id])
      else
        render json: {message: "You need to be a site admin to add a site role for someone"}, status: :ok
      end
    else
      # no params[:user_id] means you're adding your own site_role
      user = @current_user
    end
    user.site_roles << site_role
    render json: {message: "User added as #{site_role.name}"}, status: :created
  end

  def delete_role
    site_role = SiteRole.find(params[:site_role_id])
    @current_user.site_roles.find(site_role.id).delete
    render json: {message: "User is no longer #{site_role.name}"}, status: :ok
  end

  def show_roles
    user = @current_user
    if (params[:user_id] && current_user_is_admin)
      user = User.find(params[:user_id])
    end
    render json: user.site_roles, status: :ok
  end

  private
  def current_user_is_admin
    return @current_user.site_roles.include? SiteRole.find_by(name: :admin)
  end
end
