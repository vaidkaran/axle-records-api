class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :pin
      t.string :country

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
