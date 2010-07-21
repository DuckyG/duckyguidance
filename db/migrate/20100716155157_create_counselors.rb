class CreateCounselors < ActiveRecord::Migration
  def self.up
    create_table :counselors do |t|
      t.string :first_name
      t.string :last_name
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :counselors
  end
end
