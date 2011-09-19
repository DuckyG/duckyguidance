Feature: Groups

  I want to interact with the group functionality

  Scenario: Add a group
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I visit the "groups" page
    And I click the "Add a Student Group" link in the "content" section
    And I submit the group's details
    Then I should be redirected to the new group's detail page
    And the status code should be 200
