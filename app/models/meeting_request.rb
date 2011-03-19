require 'forschoolscope'
class MeetingRequest < ActiveRecord::Base

  belongs_to :counselor
  belongs_to :school
  attr_accessor :date, :time
  validate :check_date
  before_validation :aggregate_desired_date
  validates :first_name, :last_name, :counselor, :email, :presence => true
  
  scope :for_school, lambda { |current_school| where(:school_id => current_school.id) }

  def check_date
    Rails::logger.info self
    unless desired_date
      errors.add_to_base "Date and Time are required"
    end
  end
  
  def aggregate_desired_date
    unless self.date.empty? && self.time.empty?
      self.desired_date = Time.strptime("#{self.date} #{self.time}" , "%m/%d/%Y %I:%M %p") 
    end
  end
  
end
