Given /^I am at a school$/ do
  @subdomain = create(:subdomain)
  @school = create(:school, subdomain: @subdomain)
  @category = FactoryGirl.create(:category, school: @school)
  Capybara.default_host = "http://#{@subdomain.name}.ducky.local"
end
