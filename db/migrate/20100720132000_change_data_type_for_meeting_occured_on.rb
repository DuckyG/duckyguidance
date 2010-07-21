class ChangeDataTypeForMeetingOccuredOn < ActiveRecord::Migration
  def self.up
    change_table :meetings do |t|
      t.change :occured_on, :datetime
    end
  end

  def self.down
    change_table :meetings do |t|
      t.change :occured_on, :date
    end
  end
end
