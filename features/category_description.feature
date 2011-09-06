Feature: Categories

  As a user of Ducky Guidance
  I want to create, view and modify categories

  Scenario: Counselors should not see "Add a Note Category" link on the categories page
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

  Scenario: Counselors should not be able to create categories
    Given I am at a school
    And I am a counselor
    And I am logged in
    When I visit the "new category" page
    Then I should be redirected to the "dashboard" page
    And I should see an alert stating "You do not have access to this page"

  Scenario: Counselors should not be able to edit a category
    Given I am at a school
    And I am a counselor
    And I am logged in
    And there is a category
    When I visit that category's edit page
    Then I should be redirected to the "dashboard" page
    And I should see an alert stating "You do not have access to this page"

  Scenario: School admins should see "Add a Note Category" link on the categories page
    Given I am at a school
    And I am a school admin
    And I am logged in
    When I visit the "categories" page
    Then I should see a "Add a Note Category" link in the "content" section
    
  Scenario: School admins should  see a "edit" link when viewing a category
    Given I am at a school
    And I am a school admin
    And I am logged in
    And there is a category
    When I visit that category page
    Then I should see a "Edit" link in the "content" section

  Scenario: School admins should be able to create categories
    Given I am at a school
    And I am a school admin
    And I am logged in
    When I visit the "categories" page
    And I click the "Add a Note Category" link in the "content" section
    And I submit the category's details
    Then I should be redirected to the new category's detail page
    And the status code should be 200

  Scenario: School admins should be able to edit a category
    Given I am at a school
    And I am a school admin
    And I am logged in
    And there is a category
    When I visit that category page
    And I click the "Edit" link in the "content" section
    And I enter the description "This category has been updated"
    And I click the "Update This Note Category" button
    Then I should be redirected to that category's page
    And the status code should be 200
    And the description should be "This category has been updated"
