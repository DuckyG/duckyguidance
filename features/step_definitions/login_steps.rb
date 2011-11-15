When /^I log in$/ do
  login
end

Given /^I am logged in$/ do
  login
end

def login
  visit login_path
  fill_in 'Email Address', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button "user_submit"
end
