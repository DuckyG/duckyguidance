class MeetingRequest < ActiveRecord::Base

  belongs_to :counselor
  belongs_to :school
  attr_accessor :date, :time
  validate :check_date
  before_validation :aggregate_desired_date
  validates :first_name, :last_name, :counselor, :email, :presence => true
  
  scope :past, where("desired_date < '#{DateTime.now}'")
  scope :future, where("desired_date > '#{DateTime.now}'")
  scope :accepted, where(:accepted => true)
  
  default_scope order('desired_date DESC')

  def check_date
    unless desired_date
      errors.add_to_base "Date and Time are required"
    end
  end
    
  def student_full_name
    "#{first_name} #{last_name}"
  end
  
  def formatted_desired_date
    desired_date.strftime "%m/%d/%Y"
  end
  
  def formatted_desired_time
    desired_date.strftime "%I:%M %p"
   end
  
  def aggregate_desired_date
    unless self.date.nil? || self.time.nil? || self.date.empty? || self.time.empty? 
      self.desired_date = Time.strptime("#{self.date} #{self.time}" , "%Y-%m-%d %I:%M %p") 
    end
  end

  class << self
    def for_school(school)
      where(school_id: school.id)
    end
  end
  
end
