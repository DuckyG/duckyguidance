class Tag < ActiveRecord::Base
  has_and_belongs_to_many :notes, :order => "notes.created_at ASC"
  belongs_to :school
  validates_uniqueness_of :name, :scope => :school_id
end
