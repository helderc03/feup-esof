Feature: Filters on Main Page
  Scenario: Filter works correctly
    Given I log in
    And I see "HomePage"
    When I press "movieFilter2"
    Then different movies should show up on my screen