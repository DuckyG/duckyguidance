class AddDurationToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :duration, :integer
  end
end
