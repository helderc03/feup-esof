Feature: Sign Up
  Scenario: Sign Up with valid credentials
    Given I am on the "SignUpPage"
    And I have "emailField" and "usernameField" and "passwordField" and "signUpButton"
    When I fill "emailField" with "johndoe@gmail.com"
    And I fill "usernameField" with "johndoe123"
    And I fill "passwordField" with "1234567"
    And I click the "signUpButton"
    Then I should have "HomePage" on screen