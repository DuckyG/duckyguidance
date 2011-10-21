class RemoveFieldNameAndFieldValueFromSmartGroup < ActiveRecord::Migration
  def self.up
    remove_column :smart_groups, :field_name
    remove_column :smart_groups, :field_value
  end

  def self.down
  end
end
