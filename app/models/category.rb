class Category < ActiveRecord::Base
  has_many :notes, :order => "created_at ASC"
  belongs_to :school
  validates_uniqueness_of :name, :scope => :school_id, :case_sensitive => false
  validates_presence_of :name, :description
end
