Feature: Student

  As a counselor,
  I want to make sure I can perform student actions


  Scenario: Add a student from the student list page
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I visit the "students" page
    And I click the "Add a Student" link in the "content" section
    And I submit the student's details
    Then I should be redirected to the new student's detail page
    And the status code should be 200

  @wip
  Scenario: Viewing a student's notes that I wrote
    Given I am at a school
    And I am a counselor
    And I am logged in
    And there is a student
    And I have written a "Just me" level note for the student
    And I have written a "Director" level note for the student
    And I have written a "Department" level note for the student
    When I visit the student's page
    Then I should see all the notes I have written for that student
