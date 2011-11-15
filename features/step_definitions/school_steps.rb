Given /^I am at a school$/ do
  @subdomain = Factory(:subdomain)
  @school = Factory(:school, subdomain: @subdomain)

  Capybara.default_host = "http://#{@subdomain.name}.ducky.local"
end
