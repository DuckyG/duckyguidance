class Student < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  belongs_to :counselor, class_name: "User"
  has_and_belongs_to_many :groups
  has_many :guardians, dependent: :destroy

  validates_presence_of :first_name, :last_name, :counselor_id, :city, :student_id, :full_name
  validates_uniqueness_of :student_id, :scope => :school_id
  validate :validate_counselor

  attr_accessor :areaCode, :prefix, :line, :extension,:group_ids_attribute
  attr_protected :full_name
  attr_accessible :first_name, :last_name, :city, :student_id, :areaCode, :prefix, :line, :extension, :group_ids_attribute,
    :counselor_id, :shop, :year_of_graduation

  before_validation :aggregate_phone_number, :process_group_ids
  before_validation { self.full_name = "#{first_name} #{last_name}" }

  before_destroy { self.notes.clear }
  before_destroy { self.groups.clear }

  default_scope :order => 'last_name, first_name'

  VALID_SMART_FIELDS = {"Year of Graduation" => "year_of_graduation", "Shop" => "shop", "City" => "city", "Counselor" => "counselor_id"}
  SMART_FIELD_NAMES = { "year_of_graduation" => "Year of Graduation", "shop" => "Shop", "city" => "City", "counselor_id" => "Counselor"}

  class << self
    def search_by_first_or_last_name(term)
      where {(last_name.matches term) | (first_name.matches term) | (full_name.matches term)}
    end

    def current
      school_year = current_school_year
      where { year_of_graduation.gteq(school_year) & active.eq(true) }
    end

    def inactive
      school_year = current_school_year
      where { year_of_graduation.lt school_year }
    end

    def recently_graduated
      school_year = current_school_year
      where { year_of_graduation.eq school_year -1 }
    end

    def current_school_year
      end_school_year = Date.parse "#{DateTime.now.year}/07/31"

      DateTime.now.to_date > end_school_year ? DateTime.now.year + 1 : DateTime.now.year
    end

    def valid_smart_field?(field_name)
      VALID_SMART_FIELDS.values.include? field_name
    end

    def smart_fields
      VALID_SMART_FIELDS
    end

    def valid_smart_field_names
      VALID_SMART_FIELDS.keys
    end

    def smart_field_name(field)
      SMART_FIELD_NAMES[field]
    end
  end

  def aggregate_phone_number
    self.primary_phone_number = "(#{areaCode})#{prefix}-#{line}#{" ext. " + self.extension unless self.extension.nil? ||  self.extension.empty?}" if @areaCode && @prefix && @line
  end

  def distribute_phone_number
    if self.primary_phone_number && !self.primary_phone_number.empty?
      matches = /\(?(\d+)\)?-?(\d+)-(\d+)( ext. (\d+))?/.match(self.primary_phone_number)
      if matches
        @areaCode = matches[1]
        @prefix = matches[2]
        @line = matches[3]
        @extension = matches[5]
      end
    end
  end

  def validate_counselor
    unless self.counselor_id && self.counselor_id.kind_of?(Integer) && self.counselor_id > 0
      errors.add(:base, "Guidance Counselor is required")
    end
  end

  def process_group_ids
    unless group_ids_attribute == "Loading..." or group_ids_attribute.blank?
      self.groups.clear
      group_ids_attribute.split(',').each do |group_id|
        begin
          self.groups << Group.find(group_id)
        rescue ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
