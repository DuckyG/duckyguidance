class AddAllowsMeetingRequestsToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :allows_meeting_requests, :boolean
    School.all.each do |school|
      school.allows_meeting_requests = true
      school.save
    end
  end

  def self.down
    remove_column :schools, :allows_meeting_requests
  end
end
