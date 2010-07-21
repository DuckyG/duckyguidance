class CreateCounselorSessions < ActiveRecord::Migration
  def self.up
    create_table :counselor_sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :counselor_sessions, :session_id
    add_index :counselor_sessions, :updated_at
  end

  def self.down
    drop_table :counselor_sessions
  end
end