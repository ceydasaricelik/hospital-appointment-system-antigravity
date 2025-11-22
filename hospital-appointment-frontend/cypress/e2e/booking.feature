Feature: Booking

  Scenario: Book New Appointment
    Given I am logged in as a patient
    When I navigate to the booking page
    And I select a department, doctor, date, and time
    And I submit the booking form
    Then I should see the new appointment on the dashboard
