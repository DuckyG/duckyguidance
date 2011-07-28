class AddFullNameToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :full_name, :string

    execute <<-SQL
      UPDATE students
      SET full_name = first_name || ' ' || last_name
    SQL
  end

  def self.down
    remove_column :students, :full_name
  end
end
