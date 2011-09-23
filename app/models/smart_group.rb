class SmartGroup < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  validate :validate_field, :validate_value

  def validate_value
    if self.field_name == "counselor_id"
      check_counselor
    end
  end

  def validate_field
    unless Student.valid_smart_field? self.field_name
      errors.add :base, "You must select a valid field for this smart group"
    end
  end

  def friendly_field_name
    Student.smart_field_name self.field_name
  end

  def friendly_field_value
    if field_name == "counselor_id"
      begin
        counselor = school.counselors.find field_value
        return counselor.formal_name
      rescue ActiveRecord::RecordNotFound
      end
    end
    field_value
  end

  def students
    self.school.students.where(self.field_name.to_sym => self.field_value)
  end

  private

  def check_counselor
    last_name = self.field_value.split(" ").last
    counselor = school.counselors.find_by_last_name last_name

    if counselor
      self.field_value = counselor.id
    else
      begin
       school.counselors.find self.field_value
      rescue ActiveRecord::RecordNotFound
       errors.add :base, "You must enter a valid counselor"
      end
    end
  end
end
