class DropRolesAndRolesUsers < ActiveRecord::Migration
  def self.up
    execute "DROP TABLE roles_users;"
    execute "DROP TABLE roles;"
  end

  def self.down
  end
end
