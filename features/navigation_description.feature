Feature: Navigation

  So that I can use Ducky Guidance
  As a Counselor
  I want to ensure the navigation works

  Scenario Outline: click navigation Item
    Given I am a counselor
    And I am logged in
    When I click the "<name>" navigation item
    Then I should be redirected to the "<page_name>" page
    And the status code should be <status>

    Scenarios: Main Navigation
      | name            | page_name  | status |
      | Students        | students   | 200    |
      | Groups          | groups     | 200    |
      | Note Categories | categories | 200    |

    Scenarios: Tools Navigation
      | name                 | page_name    | status |
      | Search for a Student | students     | 200    |
      | Add a Student        | new_student  | 200    |
      | Add a Group          | new_group    | 200    |
      | Your Account Options | my_account   | 200    |
