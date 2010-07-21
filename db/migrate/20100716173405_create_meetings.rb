class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.date :occured_on
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
