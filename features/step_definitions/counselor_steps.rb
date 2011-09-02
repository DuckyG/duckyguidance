Given /^I am a counselor$/ do
  prefix = Factory(:name_prefix)
  @user = Factory(:counselor, school: @school, name_prefix: prefix)
end

Given /^I am a school admin/ do
  prefix = Factory(:name_prefix)
  @user = Factory(:school_admin, school: @school, name_prefix: prefix)
end
