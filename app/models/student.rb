class Student < ActiveRecord::Base
  has_and_belongs_to_many :notes, :order => "created_at ASC"
  belongs_to :school
  belongs_to :counselor
  has_and_belongs_to_many :groups
  has_many :guardians
  validates_presence_of :first_name, :last_name, :counselor_id, :city, :student_id, :full_name
  validates_uniqueness_of :student_id, :scope => :school_id
  validate :validate_counselor
  attr_accessor :areaCode, :prefix, :line, :extension
  attr_protected :full_name
  before_validation :aggregate_phone_number
  before_validation { self.full_name = "#{first_name} #{last_name}" }
  
  def aggregate_phone_number
    self.primary_phone_number = "(#{areaCode})#{prefix}-#{line}#{" ext. " + self.extension unless self.extension.empty?}" if @areaCode && @prefix && @line
  end
  def distribute_phone_number
    if self.primary_phone_number && !self.primary_phone_number.empty?
      matches = /\(?(\d+)\)?-?(\d+)-(\d+)( ext. (\d+))?/.match(self.primary_phone_number)
      if matches
      logger.info "exists in matches"
        @areaCode = matches[1]
        @prefix = matches[2]
        @line = matches[3]
        @extension = matches[5]
      end
    end
  end
  
  def validate_counselor
    unless self.counselor_id && self.counselor_id.kind_of?(Integer) && self.counselor_id > 0
      errors.add_to_base "Guidance Counselor is required"
    end
  end
end
