Feature: Sign Out
  Scenario: Successful sign out
    Given I log in
    And I go to the "ProfilePage"
    And I have a "LogOutButton"
    When I click the "LogOutButton"
    Then I should have "LoginPage" on my screen