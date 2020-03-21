class CreateSiteRoleUserJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :site_roles, :users do |t|
      t.index :site_role_id
      t.index :user_id
    end
  end
end
