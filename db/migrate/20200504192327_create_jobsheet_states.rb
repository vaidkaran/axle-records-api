class CreateJobsheetStates < ActiveRecord::Migration[5.2]
  def change
    create_table :jobsheet_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
