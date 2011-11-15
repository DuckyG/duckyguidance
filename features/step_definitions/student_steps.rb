When /^I submit the student's details$/ do
  @student = FactoryGirl.build(:student)
  fill_in "First Name", with: @student.first_name
  fill_in "Last Name", with: @student.last_name
  fill_in "City", with: @student.city
  fill_in "student_areaCode", with: @student.areaCode
  fill_in "student_prefix", with: @student.prefix
  fill_in "student_line", with: @student.line
  fill_in "Student ID", with: @student.student_id
  select @user.formal_name, from: "student_counselor_id"
  fill_in "Shop", with: @student.shop
  fill_in "Year of graduation", with: @student.year_of_graduation

  click_button "Add This Student"
end

Then /^I should be redirected to the new student's detail page$/ do
  submitted_student = Student.find_by_student_id @student.student_id

  current_path.should == student_path(submitted_student)
end

Given /^I have (\d+) students with a "([^"]*)" of "([^"]*)"$/ do |count, field, value|
  @generated_students = FactoryGirl.create_list(:student, count.to_i, field.to_sym => value, :counselor => @user, :school => @school)
end

Given /^I am on the first student's page$/ do
  visit student_path(Student.first)
end

Given /^there is a student$/ do
  @student = FactoryGirl.create(:student, counselor: @user, school: @school)
end

Given /^I have written a "([^"]*)" level note for the student$/ do |level|
  @my_notes ||= []
  level = "department" if level.blank?
  level = level.downcase.gsub(' ','_')
  category = FactoryGirl.create(:category, school:@school)
  @my_notes.push FactoryGirl.create(:note, students: [@student], category: category, counselor: @user, confidentiality_level: level)
end

When /^I visit the student's page$/ do
  visit student_path(@student)
end

Then /^I should see all the notes I have written for that student$/ do
  @my_notes.each do |note|
    page_has_note_content(note, :should)
  end
end


