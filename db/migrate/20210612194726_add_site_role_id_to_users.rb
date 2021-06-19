class AddSiteRoleIdToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.references :site_role, foreign_key: true, index: true
    end
  end
end
