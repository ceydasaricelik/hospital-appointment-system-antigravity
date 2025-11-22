Feature: Login

  Scenario: Successful Login
    Given I am on the login page
    When I enter "patient@example.com" and "password123"
    And I click login
    Then I should see the dashboard

  Scenario: Login with Wrong Password
    Given I am on the login page
    When I enter "patient@example.com" and "wrongpassword"
    And I click login
    Then I should see an error message

  Scenario: Access Protected Dashboard Without Token
    Given I am not logged in
    When I visit the dashboard
    Then I should be redirected to login
