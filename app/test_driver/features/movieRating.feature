Feature: Movie Rating
  Scenario: Movie rating shows correctly
    Given I log in
    When I click on "moviePoster"
    Then I should have "moviePage" on my screen
    And I should see the "movieRating"
