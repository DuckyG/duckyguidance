Feature: Navigation

  So that I can use Ducky Guidance
  As a Counselor
  I want to ensure the navigation works

  Scenario Outline: Navigation Items
    Given I am a counselor
    And I am logged in
    When I click the "<name>" link in the "<section>" section
    Then I should be redirected to the "<page_name>" page
    And the status code should be <status>

    Scenarios: Main Navigation
      | name            | page_name  | section   | status |
      | Students        | students   | navGlobal | 200    |
      | Groups          | groups     | navGlobal | 200    |
      | Note Categories | categories | navGlobal | 200    |

    Scenarios: Tools Navigation
      | name                 | page_name   | section   | status |
      | Search for a Student | students    | auxiliary | 200    |
      | Add a Student        | new_student | auxiliary | 200    |
      | Add a Group          | new_group   | auxiliary | 200    |
      | Your Account Options | my_account  | auxiliary | 200    |
