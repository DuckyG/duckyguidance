class SmartGroup < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  validate :validate_field

  def validate_field
    unless Student.valid_smart_field? self.field_name
      errors.add_to_base "You must select a valid field for this smart group"
    end
  end
end
