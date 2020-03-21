class RemoveSiteRoleFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :site_role_id
  end
end
