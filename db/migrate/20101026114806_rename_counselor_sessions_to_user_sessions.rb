class RenameCounselorSessionsToUserSessions < ActiveRecord::Migration
  def self.up
    rename_table :counselor_sessions, :user_sessions
  end

  def self.down
    rename_table :user_sessions, :counselor_sessions
  end
end
