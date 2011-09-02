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
    name_prefix
    first_name "John"
    last_name "Test"
    email "john@test.com"
    password "password1"
    password_confirmation "password1"

    factory :school_admin do
      after_create {|admin| admin.has_role! :school_admin, admin.school }
    end
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

  factory :group do
    name "Test Group"
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end

  factory :category do
    sequence(:name) {|n| "Test Category #{n}" }
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end

end
