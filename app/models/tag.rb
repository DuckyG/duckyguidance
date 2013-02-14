class Tag < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  validates_uniqueness_of :name, :scope => :school_id
  attr_accessible :name
end
