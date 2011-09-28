When /^I submit the group's details$/ do
  @group = FactoryGirl.build(:group)  
  fill_in "Group Name",  with: @group.name
  fill_in "Description", with: @group.description

  click_button "Add This Group"
end

Then /^I should be redirected to the new group's detail page$/ do
  submitted_group = Group.find_by_name @group.name

  current_path.should == group_path(submitted_group)
end

Then /^the group's name should be "([^"]*)"$/ do |name|
  num_of_students = find(:xpath, "//table/tbody/tr[td='Name']/td[last()]").text
  num_of_students.should eq(name)
end

Then /^the group should contain (\d+) students$/ do |count|
  num_of_students = find(:xpath, "//table/tbody/tr[td='Number of Students']/td[last()]").text
  num_of_students.should eq(count)
end

Then /^I should be redirected to the newest group's page$/ do
  current_path.should eq(group_path(Group.last))
end
