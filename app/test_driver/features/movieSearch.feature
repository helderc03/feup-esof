Feature: Searching for a movie
  Scenario: Successful search
    Given I log in
    And I go to "SearchPage"
    When I enter "Pulp Fiction" to "searchBar"
    Then "Pulp Fiction" should show up on the results