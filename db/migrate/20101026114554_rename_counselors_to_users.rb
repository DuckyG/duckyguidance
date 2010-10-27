class RenameCounselorsToUsers < ActiveRecord::Migration
  def self.up
    rename_table :counselors, :users
  end

  def self.down
    rename_table :users, :counselors
  end
end
