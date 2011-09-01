Given /^I am a counselor$/ do
  @user = Factory(:counselor, school: @school)
  @user.has_role!(:counselor, @user.school)
  @user.has_role!(:member, @user.school.subdomain)
end

