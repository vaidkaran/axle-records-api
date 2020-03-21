class UserSiteRolesController < ApplicationController
  def add_role
    site_role = SiteRole.find(params[:site_role_id])
    current_user.site_roles << site_role
    render json: {message: "User added as #{site_role.name}"}, status: :created
  end

  def delete_role
    site_role = SiteRole.find(params[:site_role_id])
    current_user.site_roles.find(site_role.id).delete
    render json: {message: "User is no longer #{site_role.name}"}, status: :ok
  end
end
