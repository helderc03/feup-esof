Feature: Commenting on a movie's page
  Scenario: Successful comment
    Given I log in
    And I go to a movie's page
    When I enter "Great Movie" to the "commentBar"
    And I click the "postButton"
    Then I should see "Great Movie" in the comment section