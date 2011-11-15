Feature: Dashboard

  As a user of Ducky Guidance
  I want to see useful information on my dashboard

  Scenario: Counselors should see notes they wrote
    Given I am at a school
    And I am a counselor
    And I am logged in
    And I have written notes for other counselors' students
    When I visit the "dashboard" page
    Then I should see the notes I wrote

  Scenario: Counselors should see notes they wrote
    Given I am at a school
    And I am a counselor
    And I am logged in
    And I have written notes for other counselors' students
    When I visit the "dashboard" page
    Then I should see the notes I wrote

  Scenario: Counselors should see notes about their students
    Given I am at a school
    And I am a counselor
    And I am logged in
    And other counselors have written notes about my students
    When I visit the "dashboard" page
    Then I should see the appropriate notes assigned to my students

  Scenario: Directors should see notes from all counselors
    Given I am at a school
    And I am a school admin
    And I am logged in
    And other counselors have written notes on students
    And there are notes on students in a different school
    When I visit the "dashboard" page
    Then I should notes from all students within my school

