require 'active_record/fixtures'
require 'csv'

counselors = CSV.read("db/counselor_names.csv", :headers => true)

sub = Subdomain.find_by_name "test"

#counselors.each do |row|
#  counselor = Counselor.new(row.to_hash)
#  counselor.email = "#{counselor.first_name}.#{counselor.last_name}@duckyg.com"
#  counselor.id=row["id"]
#  counselor.password = "p@ssw0rd#{counselor.id}"
#  counselor.password_confirmation = "p@ssw0rd#{counselor.id}"
#  counselor.school = sub.school
#  counselor.has_role! :counselor, sub.school
#  counselor.has_role! :member, sub
#  counselor.save
#end

students = CSV.read("db/students.csv", :headers => true)

students.each do |student_row|
  student = Student.new(student_row.to_hash)
  student.school = sub.school
  student.save
end