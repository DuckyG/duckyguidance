Feature: Student

  As a counselor,
  I want to make sure I can perform student actions


  Scenario: Add a student from the student list page
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I visit the "students" page
    And I click the "Add a Student" link in the "content" section
    And I enter the students details
    Then I should redirected to the new student's detail page
    And the status code should be 200
