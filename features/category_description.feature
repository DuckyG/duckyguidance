Feature: Categories

  As a user of Ducky Guidance
  I want to create, view and modify categories

  Scenario: Counselors should not be able to create categories
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I visit the "new category" page
    Then I should be redirected to the "dashboard" page
    And I should see an alert stating "You do not have access to this page"

  Scenario: Counselors should not see "Add a Note Category" link on categories page
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I visit the "categories" page
    Then I should not see a "Add a Note Category" link in the "content" section

  Scenario: Counselors should not see a "edit" link when viewing a category
    Given I am at a school
    And I am a counselor
    And I am logged in
    And there is a category
    When I visit that category page
    Then I should not see a "Edit" link in the "content" section

  Scenario: Counselors should not be able to edit a category
    Given I am at a school
    And I am a counselor
    And I am logged in
    And there is a category
    When I visit that category's edit page
    Then I should be redirected to the "dashboard" page
    And I should see an alert stating "You do not have access to this page"
