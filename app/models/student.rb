class Student < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  belongs_to :counselor
  has_and_belongs_to_many :groups
  has_many :guardians
  validates_presence_of :first_name, :last_name, :counselor_id
end
