class RemoveOccuredOnAndDurationFromNotes < ActiveRecord::Migration
  def self.up
    remove_column :notes, :duration
    remove_column :notes, :occured_on
  end

  def self.down
    add_column :notes, :duration, :integer
    add_column :notes, :occured_on, :date
  end
end
