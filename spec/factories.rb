FactoryGirl.define do
  factory :subdomain do
    sequence(:name) {|n| "test#{n}"}
  end

  factory :name_prefix do
    prefix "Mr."
  end

  factory :school do
    sequence(:name) {|n| "Testing School #{n}"}
    address "123 Plain Street"
    city "Pleasantville"
    state "Massachusetts"
    zip_code "01234"
    allows_meeting_requests false
    subdomain
  end

  factory :counselor do
    name_prefix
    first_name "John"
    last_name "Test"
    sequence(:email) {|n| "john#{n}@test.com"}
    password "password1"
    password_confirmation "password1"
    role "counselor"

    factory :school_admin do
      role "director"
    end
  end
 
  factory :student do
    first_name "Joe"
    sequence(:last_name) {|n| "Student#{n}"}
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
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  end

  factory :category do
    sequence(:name) {|n| "Test Category #{n}" }
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  end

  factory :note do
    sequence(:summary) {|n| "Note summary #{n}" }
    confidentiality_level "department"
    sequence(:occurred_on) {|n| n.days.ago}
    sequence(:notes) {|n| "Note text for note ##{n}"}
  end

end
