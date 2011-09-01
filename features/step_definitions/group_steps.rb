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

