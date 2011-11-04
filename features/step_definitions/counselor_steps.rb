Given /^I am a counselor$/ do
  prefix = Factory(:name_prefix)
  @user = Factory(:counselor, school: @school, name_prefix: prefix)
end

Given /^I am a school admin/ do
  prefix = Factory(:name_prefix)
  @user = Factory(:school_admin, school: @school, name_prefix: prefix)
end

Given /^I have written notes for other counselors' students$/ do
  counselors = FactoryGirl.create_list(:counselor, 5, school: @school)
  category = FactoryGirl.create(:category)
  counselors.each do |counselor|
    student = FactoryGirl.create(:student,counselor:counselor)
    FactoryGirl.create(:note, counselor: @user, category: category, students:[student])
  end
end

Then /^I should see the notes I wrote$/ do
  @user.notes.each do |note|
    have_note_content(note, @user)
  end
end


Given /^other counselors have written( "([^"]*)" level)? notes about my students$/ do |level_group, level|
  level = "department" if level.blank?
  level = level.downcase.gsub(' ','_')
  counselors = FactoryGirl.create_list(:counselor, 5, school: @school)
  category = FactoryGirl.create(:category)
  counselors.each do |counselor|
    student = FactoryGirl.create(:student,counselor:@user)
    FactoryGirl.create(:note, counselor: counselor, confidentiality_level: level, category: category, students:[student])
  end
end


Then /^I should see the appropriate notes assigned to my students$/ do
  @user.students.map(&:notes).flatten.each do |note|
    have_note_content(note,@user)
  end
end

