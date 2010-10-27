class ChangeSchoolSubdomainToForeignKey < ActiveRecord::Migration
  def self.up
    change_column :schools, :subdomain, :int
    rename_column :schools, :subdomain, :subdomain_id
    add_foreign_key :schools, :subdomains
  end

  def self.down
    rename_column :schools, :subdomain_id, :subdomain
    change_column :schools, :subdomain, :int    
    drop_foreign_key :schools, :subdomains
  end
end
