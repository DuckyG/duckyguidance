class SmartGroup < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
end
