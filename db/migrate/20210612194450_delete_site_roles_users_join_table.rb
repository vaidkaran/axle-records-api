class DeleteSiteRolesUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :site_roles_users
  end
end
