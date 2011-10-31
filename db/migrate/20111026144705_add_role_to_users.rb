class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string
    add_column :users, :super_admin, :boolean

    User.all.each do |user|
      user.role = user.has_role?(:school_admin, user.school) ? "director" : "counselor"
      user.super_admin = user.has_role?(:superadmin)
      user.save
    end
  end

  def self.down
    remove_column :users, :role
    remove_column :users, :super_admin
  end
end
