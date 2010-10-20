class Category < ActiveRecord::Base
  has_many :meetings
  belongs_to :school
  validates_uniqueness_of :name, :scope => :school_id
end
