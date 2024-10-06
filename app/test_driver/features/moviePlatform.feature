Feature: Movie Platforms on movie page
  Scenario: Movie Platforms show up correctly
    Given I log in
    When I click on "moviePoster"
    Then I should have "moviePage" on my screen
    And I should see the "moviePlatforms"