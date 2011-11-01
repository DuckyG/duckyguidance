class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string
    add_column :users, :super_admin, :boolean

    execute <<-SQL
      UPDATE users
      SET role = 'counselor'
    SQL

    execute <<-SQL
      UPDATE users AS u
      SET role = 'director'
      FROM roles as r, roles_users ru
      WHERE u.school_id = r.authorizable_id and r.name = 'school_admin' and ru.user_id = u.id and r.id = ru.role_id;
    SQL
  end

  def self.down
    remove_column :users, :role
    remove_column :users, :super_admin
  end
end
