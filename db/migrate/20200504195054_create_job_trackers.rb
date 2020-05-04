class CreateJobTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :job_trackers do |t|
      t.belongs_to :jobsheet, index: true, foreign_key: true
      t.belongs_to :job_profile, index: true, foreign_key: true

      t.timestamps
    end
  end
end
