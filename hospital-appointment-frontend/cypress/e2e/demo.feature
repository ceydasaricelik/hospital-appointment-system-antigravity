Feature: Demo Flow

  Scenario: Full Application Demo
    Given I am on the login page
    When I enter "patient@example.com" and "password123"
    And I click login
    Then I should see the dashboard
    When I navigate to the booking page
    And I select a department, doctor, date, and time
    And I submit the booking form
    Then I should see the new appointment on the dashboard
