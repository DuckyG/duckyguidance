class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string
    add_column :users, :super_admin, :boolean

    execute <<-SQL
      UPDATE users
      SET role = 'counselor'
    SQL

    execute <<-SQL
      UPDATE users
      SET role = 'director'
      FROM roles r, roles_users ru
      WHERE users.school_id = r.authorizable_id and r.name = 'school_admin' and ru.user_id = users.id and r.id = ru.role_id;
    SQL
  end

  def self.down
    remove_column :users, :role
    remove_column :users, :super_admin
  end
end
