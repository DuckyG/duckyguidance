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

