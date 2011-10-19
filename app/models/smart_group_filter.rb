class SmartGroupFilter < ActiveRecord::Base
  belongs_to :smart_group
  validate :validate_field, :validate_value

  def validate_value
    if self.field_name == "counselor_id"
      check_counselor
    end
    if self.field_name == "year_of_graduation"
      check_year_of_graduation
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
        if field_value.to_i != 0
          counselor = smart_group.school.counselors.find field_value
          return counselor.formal_name
        end
      rescue ActiveRecord::RecordNotFound
      end
    end
    field_value
  end

  private

  def check_counselor
    last_name = self.field_value.split(" ").last
    counselor = smart_group.school.counselors.find_by_last_name last_name

    if counselor
      self.field_value = counselor.id
    else
      begin
       smart_group.school.counselors.find self.field_value.to_i
      rescue ActiveRecord::RecordNotFound
       errors.add :base, "You must enter a valid counselor"
      end
    end
  end

  def check_year_of_graduation
    self.field_value = self.field_value.to_i
  end

end
