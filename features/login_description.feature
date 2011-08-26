Feature: Counselor Sessions

  So that I can use Ducky Guidance
  As a Counselor
  I want to log in
  And log out

  Scenario: Log in
    Given I am a counselor
    When I log in
    Then I should be redirected to the "dashboard" page
    And the status code should be 200

  Scenario: Log out
    Given I am a counselor
    And I am logged in
    When I visit the "logout" page
    Then I should be redirected to the "login" page
    And the status code should be 200
