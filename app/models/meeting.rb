class Meeting < ActiveRecord::Base
  belongs_to :student
  belongs_to :counselor
  attr_accessor :date, :start_time, :end_time
  validates :student, :counselor, :occured_on, :notes, :summary, :presence => true 
  
  def get_duration
    Time.parse(@end_time) - Time.parse(@start_time) 
  end
  
  def get_occured_on
    @date + " " + @start_time
  end
  
  def duration_hours_min
    minutes = 0
    hours = 0
    if duration
      minutes = duration/60
      hours = minutes/60
    end
    return hours,minutes%60
  end
  
end
