Feature: Manage posts
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new post
    Given I am on the new post page
    When I fill in "Title" with "title 1"
    And I fill in "Body" with "body 1"
    And I fill in "Number" with "1"
    And I uncheck "Published"
    And I press "Create"
    Then I should see "title 1"
    And I should see "body 1"
    And I should see "1"
    And I should see "false"

  Scenario: Delete post
    Given the following posts:
      |title|body|number|published|
      |title 1|body 1|1|false|
      |title 2|body 2|2|true|
      |title 3|body 3|3|false|
      |title 4|body 4|4|true|
    When I delete the 3rd post
    Then I should see the following posts:
      |Title|Body|Number|Published|
      |title 1|body 1|1|false|
      |title 2|body 2|2|true|
      |title 4|body 4|4|true|
