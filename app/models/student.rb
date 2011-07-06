class Student < ActiveRecord::Base
  has_and_belongs_to_many :notes, :order => "created_at ASC"
  belongs_to :school
  belongs_to :counselor
  has_and_belongs_to_many :groups
  has_many :guardians
  validates_presence_of :first_name, :last_name, :counselor_id, :city, :student_id
  validates_uniqueness_of :student_id, :scope => :school_id
  validate :validate_counselor
  attr_accessor :areaCode, :prefix, :line, :extension
  before_validation :aggregate_phone_number
  
  def aggregate_phone_number
    primary_phone_number = "(#{self.areaCode})#{self.prefix}-#{self.line}#{" ext. " + self.extension unless self.extension.empty?}" if @areaCode && @prefix && @line
  end
  def distribute_phone_number
    if self.primary_phone_number && !self.primary_phone_number.empty?
      matches = /\((\d{3})\)(\d{3})-(\d{4}) ext\. (\d+)/.match(self.primary_phone_number)
      if matches
        @areaCode = matches[1]
        @prefix = matches[2]
        @line = matches[3]
        @extension = matches[4]
      end
    end
  end
  
  def validate_counselor
    unless self.counselor_id && self.counselor_id.kind_of?(Integer) && self.counselor_id > 0
      errors.add_to_base "Guidance Counselor is required"
    end
  end
  
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
end
