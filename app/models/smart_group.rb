class SmartGroup < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  validate :validate_field

  def validate_field
    unless Student.valid_smart_field? self.field_name
      errors.add :base, "You must select a valid field for this smart group"
    end
  end

  def friendly_field_name
    Student.smart_field_name self.field_name
  end

  def friendly_field_value
    return school.counselors.find(field_value).formal_name if field_name == "counselor_id"
    field_value
  end

  def students
    self.school.students.where(self.field_name.to_sym => self.field_value)
  end
end
