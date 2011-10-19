class CreateSmartGroupFilters < ActiveRecord::Migration
  def self.up
    create_table :smart_group_filters do |t|
      t.string :field_name
      t.string :field_value
      t.integer :smart_group_id
      t.timestamps
    end

    SmartGroup.all.each do |sg|
      sg.smart_group_filters << SmartGroupFilter.new(field_name: sg.field_name, field_value: sg.field_value)
      sg.save
    end
  end

  def self.down
    drop_table :smart_group_filters
  end
end
