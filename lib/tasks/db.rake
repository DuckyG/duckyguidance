require 'csv'
require 'nokogiri'
namespace :db do
  task :seed, [:subdomain] do |t,args|
    
    if Rails.env.production?
      puts "Seeding production, now exiting to protect data"
      exit!
    end
    
    sub = Subdomain.find_by_name args[:subdomain]
    
    unless sub
      puts "Subdomain not found, exiting"
      exit!
    end
    
    counselors = CSV.read("db/counselor_names.csv", :headers => true)

    counselors.each do |row|
      counselor= Counselor.find_by_email "#{row["first_name"]}.#{row["last_name"]}@duckyg.com"
      
      unless counselor
        counselor = Counselor.new(row.to_hash)
        counselor.email = "#{counselor.first_name}.#{counselor.last_name}@duckyg.com"
        counselor.id=row["id"]
        counselor.password = "p@ssw0rd#{counselor.id}"
        counselor.password_confirmation = "p@ssw0rd#{counselor.id}"
        counselor.school = sub.school
        counselor.has_role! :counselor, sub.school
        counselor.has_role! :member, sub
        counselor.save
      end
    end

    students = CSV.read("db/students.csv", :headers => true)

    students.each do |student_row|
      student = sub.school.students.find_by_student_id student_row["student_id"]
      
      unless student
        student = Student.new(student_row.to_hash)
        student.school = sub.school
        student.save
      end
    end
    
    f = File.open("db/categories.xml")
    categories = Nokogiri::XML(f)
    f.close
    
    categories.xpath('//category').each do |category|
      as_hash = {}
      category.children.each do |child|
        as_hash[child.name.gsub('-','_')] = child.content
      end
      as_hash.delete "text"
      cat = sub.school.categories.find_by_name as_hash['name']
      unless cat
        cat = Category.new as_hash
        cat.description = cat.name if cat.description.nil? || cat.description.empty?
        cat.school = sub.school
        cat.id = as_hash['id']
        cat.save!
      end
    end
    
  end

end