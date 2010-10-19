class Counselor < ActiveRecord::Base
  acts_as_authentic
  has_many :meetings
  has_many :meeting_requests
  belongs_to :school
  validate :school, :presence => true
end
