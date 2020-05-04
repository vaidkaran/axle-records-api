class CreateJobsheets < ActiveRecord::Migration[5.2]
  def change
    create_table :jobsheets do |t|
      t.belongs_to :vehicle, index: true, foreign_key: true
      t.belongs_to :shop, index: true, foreign_key: true

      t.timestamps
    end
  end
end
