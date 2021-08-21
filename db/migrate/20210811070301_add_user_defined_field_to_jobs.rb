class AddUserDefinedFieldToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :user_defined, :boolean
  end
end
