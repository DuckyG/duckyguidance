Feature: Navigation

  So that I can use Ducky Guidance
  As a Counselor
  I want to ensure the navigation works

  Scenario Outline: Counselor Navigation Items
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I click the "<name>" link in the "<section>" section
    Then I should be redirected to the "<page_name>" page
    And the status code should be <status>

    Scenarios: Main Navigation
      | name            | page_name  | section   | status |
      | Students        | students   | navGlobal | 200    |
      | Groups          | groups     | navGlobal | 200    |
      | Note Categories | categories | navGlobal | 200    |