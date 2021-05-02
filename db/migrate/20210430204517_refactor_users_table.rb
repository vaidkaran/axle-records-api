class RefactorUsersTable < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :allow_password_change
      t.remove :remember_created_at
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
      t.remove :unconfirmed_email
      t.remove :nickname
      t.remove :image
      t.remove :tokens
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip

      t.string :picture
      t.string :given_name
      t.string :family_name
      t.string :locale
    end 
  end
end
