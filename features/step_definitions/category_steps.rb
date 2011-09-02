Given /^there is a category$/ do
  @category = Factory(:category, school: @school)
end

When /^I visit that category page$/ do
  visit category_path(@category)
end

When /^I visit that category's edit page$/ do
  visit edit_category_path(@category)
end
