class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.decimal :total_amount, precision: 7, scale: 2 # upto 2 decimal digits
      t.belongs_to :jobsheet, index: true, foreign_key: true

      t.timestamps
    end
  end
end
