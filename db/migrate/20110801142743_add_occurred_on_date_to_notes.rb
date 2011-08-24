class AddOccurredOnDateToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :occurred_on, :date
    Note.all.each do |note|
      note.occurred_on = note.created_at.to_date
      note.save!
    end
  end

  def self.down
    remove_column :notes, :occurred_on
  end
end
