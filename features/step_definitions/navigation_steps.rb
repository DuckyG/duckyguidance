When /^I visit the "([^"]*)" page$/ do |page|
  visit send("#{page.gsub(/ /, "_")}_path".to_sym)
end

Then /^the status code should be (\d+)$/ do |status_code|
  page.driver.response.status.should == status_code.to_i
end

Then /^I should be redirected to the "([^"]*)" page$/ do |page|
  current_path.should == send("#{page}_path".to_sym)
end

When /^I click the "([^"]*)" link in the "([^"]*)" section$/ do |link_name, section|
  within("##{section}") do
    click_link link_name
  end
end

Then /^I should not see a "([^"]*)" link in the "([^"]*)" section$/ do |link_name, section|
  within("##{section}") do
    page.should have_no_link(link_name)
  end
end

Then /^I should see a "([^"]*)" link in the "([^"]*)" section$/ do |link_name, section|
  within("##{section}") do
    page.should have_link(link_name)
  end
end

When /^I click the "([^"]*)" button$/ do |button_text|
  click_button button_text
end

