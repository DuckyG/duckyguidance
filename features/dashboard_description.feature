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

  Scenario: Counselors should not see "Just me" level confidential notes about their students
    Given I am at a school
    And I am a counselor
    And I am logged in
    And other counselors have written "Just me" level notes about my students
    When I visit the "dashboard" page
    Then I should see the appropriate notes assigned to my students
