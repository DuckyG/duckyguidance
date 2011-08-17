Feature: Counselor Logs in

  So that I can use Ducky Guidance
  As a Counselor
  I want to log in

  Scenario: Log in
    Given I am a counselor
    And I am on the login page
    When I log in
    Then I should be redirected to the dashboard
