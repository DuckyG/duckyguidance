class SmartGroup < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  has_many :smart_group_filters

  attr_accessor :smart_group_filters_attributes
  attr_accessor :deleted_filters
  before_validation :process_smart_group_filter, :process_delete_filters

  class << self
    def find_by_field_name_and_field_value(field_name, field_value)
      smart_groups = joins(:smart_group_filters).where('smart_group_filters.field_name' => field_name,'smart_group_filters.field_value' => field_value).to_a
      smart_groups.select{|sg| sg.smart_group_filters.count == 1}.first
    end
  end

  def students
    unless @students
      @students = self.school.students.current

      self.smart_group_filters.each do |filter|
        @students = @students.where(filter.field_name.to_sym => filter.field_value)
      end
    end
    @students
  end

  def process_delete_filters
    if deleted_filters
    deleted_filters.split(",").each do |fid|
      unless fid =~ /^new/
        begin
          filter = self.smart_group_filters.find(fid)
          filter.destroy
        rescue
        end
      end
    end
    end
  end

  def process_smart_group_filter
    if smart_group_filters_attributes
    smart_group_filters_attributes.each do |key, hash|
      if key =~ /^new/
        self.smart_group_filters << SmartGroupFilter.new(hash)
      else
        filter = self.smart_group_filters.find key
        unless(filter.update_attributes(hash))
          filter.errors.full_messages.each do |error|
            errors.add :base, error
          end
        end
      end
    end
    end
  end
end
