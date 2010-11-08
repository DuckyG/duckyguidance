class MigrateNotesRelations < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      INSERT INTO students_notes
      SELECT student_id, id
      FROM notes
    SQL
  end

  def self.down
    execute "DELETE FROM students_notes"
  end
end
