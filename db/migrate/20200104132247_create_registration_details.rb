class CreateRegistrationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_details do |t|
      t.string :reg_number
      t.belongs_to :vehicle, index: true

      t.timestamps
    end
  end
end
