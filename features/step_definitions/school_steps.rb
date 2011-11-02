Given /^I am at a school$/ do
  @subdomain = Factory(:subdomain)
  @school = Factory(:school, subdomain: @subdomain)
end
