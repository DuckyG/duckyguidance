class MeetingRequest < ActiveRecord::Base
  belongs_to :counselor
  attr_accessor :date, :time
  validates :first_name, :last_name, :counselor_id, :email, :presence => true 
end
