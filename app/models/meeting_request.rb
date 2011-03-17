class MeetingRequest < ActiveRecord::Base
  belongs_to :counselor
  belongs_to :school
  attr_accessor :date, :time
  validates :first_name, :last_name, :counselor, :email, :date, :time, :presence => true 
end
