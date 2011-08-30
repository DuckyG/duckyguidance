When /^I visit the "([^"]*)" page$/ do |page|
  visit send("#{page}_path".to_sym)
end

Then /^the status code should be (\d+)$/ do |status_code|
  page.driver.response.status.should == status_code.to_i
end

Then /^I should be redirected to the "([^"]*)" page$/ do |page|
  current_path.should == send("#{page}_path".to_sym)
end

When /^I click the "([^"]*)" navigation item$/ do |link_name|
  click_link link_name
end

