Given /^there is a category$/ do
  @category = create(:category, school: @school)
end

When /^I visit that category page$/ do
  visit category_path(@category)
end

When /^I visit that category's edit page$/ do
  visit edit_category_path(@category)
end

When /^I submit the category's details$/ do
  @category = build(:category)
  fill_in "Note Category Name", with: @category.name
  fill_in "Description", with: @category.description

  click_button "Add This Note Category"
end

Then /^I should be redirected to the new category's detail page$/ do
  submitted_category = Category.find_by_name @category.name

  current_path.should == category_path(submitted_category)
end

When /^I enter the description "([^"]*)"$/ do |new_description|
  fill_in "Description", with: new_description
end

Then /^I should be redirected to that category's page$/ do
  current_path.should == category_path(@category)
end

Then /^the description should be "([^"]*)"$/ do |new_description|
  page.should have_content(new_description)
end

