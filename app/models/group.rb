class Group < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_and_belongs_to_many :notes
  belongs_to :school
  validates_presence_of :name, :description
  validates_uniqueness_of :name, :scope => :school_id, :case_sensitive => false

  default_scope :order => "name"
end
