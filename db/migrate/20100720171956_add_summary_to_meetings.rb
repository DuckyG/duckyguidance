class AddSummaryToMeetings < ActiveRecord::Migration
  def self.up
    add_column :meetings, :summary, :string
  end

  def self.down
    remove_column :meetings, :summary
  end
end
