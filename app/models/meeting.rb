class Meeting < ActiveRecord::Base
  belongs_to :student
  belongs_to :counselor
  
  validates :student, :counselor, :occured_on, :notes, :summary, :presence => true 
end
