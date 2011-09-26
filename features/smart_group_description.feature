Feature: Smart Groups

  As a counselor,
  I want to use smart groups to dynamically group students based on their attributes

  Scenario: Add a smart group for year of graduation from the groups page
    Given I am at a school
    And I am a counselor
    And I am logged in
    And I have 20 students with a "year_of_graduation" of "2015"
    When I visit the "groups" page
    And I click the "Add a Smart Group" link in the "content" section
    And I enter "Students of 2015" for the "Name" field
    And I select "Year of Graduation" for the "Field name" field
    And I enter "2015" for the "Field value" field
    And I click the "Add This Smart Group" button
    Then I should be redirected to the new smart group's detail page
    And the smart group should contain 20 students

  Scenario: Clicking the year of graduation for a student when there is no smart group
    Given I am at a school
    And I am a counselor
    And I am logged in
    And I have 5 students with a "year_of_graduation" of "2012"
    And I am on the first student's page
    When I click the "2012" link in the "content" section
    Then I should be redirected to the "new_smart_group" page

  Scenario: Making a snapshot of a smart group
    Given I am at a school
    And I am a counselor
    And I am logged in
    And I have 5 students with a "year_of_graduation" of "2012"
    And there is a smart group for the year of 2012
    And I am on the first smart group's detail page
    When I enter "Year of 2012" for the "Name" field
    And I enter "Snapshot of the juniors of 2011" for the "Description" field
    And I click the "Create Group" button
    Then I should be redirected to the newest group's page
    And the group's name should be "Year of 2012"
    And the group should contain 5 students

  @wip
  Scenario: Making a snapshot of a smart group
    Given I am at a school
    And I am a counselor
    And I am logged in
    And I have 5 students with a "year_of_graduation" of "2012"
    And there is a smart group for the year of 2012
    And I am on the first smart group's detail page
    When I click the "2012" link in the "content" section
    Then I should be redirected to the "new_smart_group" page
