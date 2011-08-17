FactoryGirl.define do
  factory :subdomain do
    name 'test'
  end

  factory :school do
    subdomain
    name 'Testing School'
    address '123 Plain Street'
    city 'Pleasantville'
    state 'Massachusetts'
    zip_code '01234'
    allows_meeting_requests false
  end

  factory :counselor do
    school
    first_name 'John'
    last_name 'Test'
    email 'john@test.com'
    password 'password1'
    password_confirmation 'password1'
  end
end
