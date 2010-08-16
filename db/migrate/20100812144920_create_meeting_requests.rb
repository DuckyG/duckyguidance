class CreateMeetingRequests < ActiveRecord::Migration
  def self.up
    create_table :meeting_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :notes
      t.datetime :desired_date
      t.integer :counselor_id
      t.timestamps
    end
  end

  def self.down
    drop_table :meeting_requests
  end
end
