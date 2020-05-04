class CreateJobsheetStateTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :jobsheet_state_trackers do |t|
      t.belongs_to :jobsheet, index: true, foreign_key: true
      t.belongs_to :jobsheet_state, index: true, foreign_key: true

      t.timestamps
    end
  end
end
