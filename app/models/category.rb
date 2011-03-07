class Category < ActiveRecord::Base
  has_many :notes
  belongs_to :school
  validates_uniqueness_of :name, :scope => :school_id, :case_sensitive => false
end
