require 'spec_helper'

feature 'Managing my account' do
  scenario 'Updating a password with a valid password' do
    school = create :school, :subdomain => create(:subdomain)
    counselor = create :counselor, :school => school
    Capybara.default_host = "http://#{school.subdomain.name}.ducky.local"

    visit root_path

    fill_in 'Email Address', :with => counselor.email
    fill_in 'Password', :with => counselor.password
    click_button 'Login'

    current_path.should eq dashboard_path
  end
end
