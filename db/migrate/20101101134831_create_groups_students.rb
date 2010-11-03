class CreateGroupsStudents < ActiveRecord::Migration
  def self.up
    create_table :groups_students, :id => false, :force => true do |t|
      t.integer :group_id
      t.integer :student_id

      t.timestamps
    end
    add_index :groups_students, :student_id
    add_index :groups_students, :group_id
    add_index :groups_students, [:student_id, :group_id], :unique => true
    add_foreign_key :groups_students, :students
    add_foreign_key :groups_students, :groups
  end

  def self.down
    drop_foreign_key :groups_students, :users
    drop_foreign_key :groups_students, :roles
    remove_index :groups_students, :student_id
    remove_index :groups_students, :group_id
    remove_index :groups_students, [:student_id, :group_id]
    drop_table :groups_students
  end

end
