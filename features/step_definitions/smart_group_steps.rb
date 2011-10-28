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
  smart_filter = SmartGroupFilter.new
  smart_filter.field_name = "year_of_graduation"
  smart_filter.field_value = year
  @new_smart_group.smart_group_filters << smart_filter
  @new_smart_group.save!
end

Given /^I am on the first smart group's detail page$/ do
  visit smart_group_path(SmartGroup.first)
end

Then /^I should be redirected to the smart group with a "([^"]*)" of "([^"]*)"$/ do |field, value|
  smart_group = @school.smart_groups.find_by_field_name_and_field_value(field, value)

  current_path.should eq(smart_group_path(smart_group))
end

