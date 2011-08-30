Given /^I am a counselor$/ do
  @user = Factory(:counselor)
  @user.has_role!(:counselor, @user.school)
  @user.has_role!(:member, @user.school.subdomain)
end

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
  click_button "user_session_submit"
end
