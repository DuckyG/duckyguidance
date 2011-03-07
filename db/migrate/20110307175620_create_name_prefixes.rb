class CreateNamePrefixes < ActiveRecord::Migration
  def self.up
    create_table :name_prefixes do |t|
      t.string :prefix
    end
    
    ['Mr.','Mrs.','Miss','Dr.'].each do |pref|
      execute "INSERT INTO name_prefixes (prefix) VALUES ('#{pref}')"
    end
    
  end

  def self.down
    drop_table :name_prefixes
  end
end
