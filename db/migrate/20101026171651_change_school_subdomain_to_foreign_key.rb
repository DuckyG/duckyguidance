class ChangeSchoolSubdomainToForeignKey < ActiveRecord::Migration
  def self.up
    remove_column :schools, :subdomain
    add_column :schools, :subdomain_id, :int
    add_foreign_key :schools, :subdomains
  end

  def self.down
    drop_foreign_key :schools, :subdomains
    remove_column :schools, :subdomain_id
    add_column :schools, :subdomain, :string
    
  end
end
