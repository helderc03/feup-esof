Feature: Login
  Scenario: Login with valid credentials
    Given I have "emailField" and "passwordField" and "loginButton"
    When I fill "emailField" with "a@gmail.com"
    And I fill "passwordField" with "123456"
    And I click the "loginButton"
    Then I should have "HomePage" on screen