class CreateSmartGroupFilters < ActiveRecord::Migration
  def self.up
    create_table :smart_group_filters do |t|
      t.string :field_name
      t.string :field_value
      t.integer :smart_group_id
      t.timestamps
    end

    execute <<-SQL
      INSERT INTO smart_group_filters(smart_group_id, field_name, field_value)
      SELECT id, field_name, field_value
      FROM smart_groups
    SQL
  end

  def self.down
    drop_table :smart_group_filters
  end
end
