Feature: User Login
  As a user
  I want to log in
  So that I can access the system

  Scenario: Successful login
    Given a registered user with email "patient@example.com" and password "password123"
    When the client sends a POST request to "/api/v1/auth/login" with:
      | email    | patient@example.com |
      | password | password123         |
    Then the response status should be 200
    And the response should include a JWT token

  Scenario: Login with wrong password
    Given a registered user with email "patient@example.com" and password "password123"
    When the client sends a POST request to "/api/v1/auth/login" with:
      | email    | patient@example.com |
      | password | wrongpassword       |
    Then the response status should be 401
    And the response should include an error message "Invalid email or password"
