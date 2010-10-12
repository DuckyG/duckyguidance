class RemoveLoginFromCounselors < ActiveRecord::Migration
  def self.up
    remove_column :counselors, :login
  end

  def self.down
    add_column :counselors, :login, :string
  end
end
