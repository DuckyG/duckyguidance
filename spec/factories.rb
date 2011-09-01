FactoryGirl.define do
  factory :subdomain do
    name "test"
  end

  factory :name_prefix do
    prefix "Mr."
  end

  factory :school do
    subdomain
    name "Testing School"
    address "123 Plain Street"
    city "Pleasantville"
    state "Massachusetts"
    zip_code "01234"
    allows_meeting_requests false
  end

  factory :counselor do
    school
    name_prefix
    first_name "John"
    last_name "Test"
    email "john@test.com"
    password "password1"
    password_confirmation "password1"
  end

  factory :student do
    first_name "Joe"
    last_name "Student"
    city "Boston"
    areaCode "617"
    prefix "555"
    line "1234"
    sequence(:student_id) {|n| "#{n}"}
    shop "Carpentry"
    year_of_graduation "2013"
  end
end
