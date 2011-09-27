Then /^I should be redirected to the new smart group's detail page$/ do
  @new_smart_group = SmartGroup.last

  current_path.should eq(smart_group_path(@new_smart_group))
end

Then /^the smart group should contain (\d+) students$/ do |count|
  num_of_students = find(:xpath, "//table/tbody/tr[td='Number of Students']/td[last()]").text
  num_of_students.should eq(count)
end

Given /^there is a smart group for the year of (\d+)$/ do |year|
  @new_smart_group = @school.smart_groups.build
  @new_smart_group.name = "Year of #{year}"
  @new_smart_group.field_name = "year_of_graduation"
  @new_smart_group.field_value = year
  @new_smart_group.save!
end

Given /^I am on the first smart group's detail page$/ do
  visit smart_group_path(SmartGroup.first)
end

Then /^I should be redirected to the smart group with a "([^"]*)" of "([^"]*)"$/ do |field, value|
  smart_group = @school.smart_groups.where(field_name: field, field_value: value).first

  current_path.should eq(smart_group_path(smart_group))
end

