Given /^I am a counselor$/ do
  prefix = create(:name_prefix)
  @user = create(:counselor, school: @school, name_prefix: prefix)
end

Given /^I am a school admin/ do
  prefix = create(:name_prefix)
  @user = create(:school_admin, school: @school, name_prefix: prefix)
end

Given /^I have written notes for other counselors' students$/ do
  @visible_notes ||= []
  counselors = FactoryGirl.create_list(:counselor, 5, school: @school)
  counselors.each do |counselor|
    student = FactoryGirl.create(:student,counselor:counselor)
    @visible_notes.push FactoryGirl.create(:note, counselor: @user, category: @category, students:[student])
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
  counselors.each do |counselor|
    student = FactoryGirl.create(:student,counselor:@user)
    FactoryGirl.create(:note, counselor: counselor, confidentiality_level: level, category: @category, students:[student])
  end
end


Then /^I should see the appropriate notes assigned to my students$/ do
  @user.students.map(&:notes).flatten.each do |note|
    have_note_content(note,@user)
  end
end


Given /^other counselors have written notes on students$/ do
  @visible_notes ||= []
  counselors = FactoryGirl.create_list(:counselor, 5, school: @school)
  counselors.each do |counselor|
    student = FactoryGirl.create(:student,counselor:counselor)
    @visible_notes.push FactoryGirl.create(:note, counselor: counselor, category: @category, students:[student])
  end

end

Given /^there are notes on students in a different school$/ do
  @hidden_notes ||= []
  school2 = FactoryGirl.create(:school, subdomain: FactoryGirl.create(:subdomain))
  category = FactoryGirl.create(:category, school: school2)
  counselors = FactoryGirl.create_list(:counselor, 5, school: school2)
  counselors.each do |counselor|
    student = FactoryGirl.create(:student,counselor:counselor)
    @hidden_notes.push FactoryGirl.create(:note, counselor: counselor, category: category, students:[student])
  end
end

Then /^I should notes from all students within my school$/ do
  @visible_notes.each do |note|
    page_has_note_content(note, :should)
  end
  @hidden_notes.each do |note|
    page_has_note_content(note, :should_not)
  end
end


