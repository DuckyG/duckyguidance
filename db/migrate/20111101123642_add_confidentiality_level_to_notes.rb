class AddConfidentialityLevelToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :confidentiality_level, :string, default: "department"
    execute <<-SQL
      UPDATE notes
      set confidentiality_level = 'department'
    SQL
  end

  def self.down
    remove_column :notes, :confidentiality_level
  end
end
