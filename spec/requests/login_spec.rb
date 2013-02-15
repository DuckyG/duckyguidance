require 'spec_helper'

feature 'Logging in' do
  scenario 'Valid credentials' do
    counselor = create :counselor, :school => @school
    visit root_path

    fill_in 'Email Address', :with => counselor.email
    fill_in 'Password', :with => counselor.password
    click_button 'Login'

    current_path.should eq dashboard_path
  end
end
