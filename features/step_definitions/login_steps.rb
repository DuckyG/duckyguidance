Given /^I am a counselor$/ do
  Capybara.default_host = "http://test.ducky.local"
  @user = Factory(:counselor)
  @user.has_role!(:counselor, @user.school)
  @user.has_role!(:member, @user.school.subdomain)
end

When /^I log in$/ do
  visit login_path
  fill_in 'Email Address', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button "user_session_submit"
end

Then /^I should be redirected to the dashboard$/ do
  current_path.should == dashboard_path  
end

