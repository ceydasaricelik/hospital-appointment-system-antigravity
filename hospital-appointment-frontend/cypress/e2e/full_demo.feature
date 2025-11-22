Feature: Hospital Management System - Complete Demo

  Scenario: Full System Demonstration
    # Login Flow (20 seconds)
    Given I am on the login page
    When I enter credentials
    And I submit the login form
    Then I should see the dashboard
    
    # Dashboard View (10 seconds)
    When I view the dashboard statistics
    
    # Departments (10 seconds)
    When I navigate to departments
    Then I should see the departments list
    
    # Doctors (30 seconds)
    When I navigate to doctors
    And I click add doctor
    And I enter doctor details
    And I save the doctor
    Then I should see doctor added confirmation
    
    # Patients (30 seconds)
    When I navigate to patients
    And I click add patient
    And I enter patient details
    And I save the patient
    Then I should see patient added confirmation
    
    # Appointments (30 seconds)
    When I navigate to appointments
    And I click book appointment
    And I select doctor and patient
    And I set appointment details
    And I confirm the appointment
    Then I should see appointment created confirmation
    
    # Final Dashboard (10 seconds)
    When I return to dashboard
    Then I should see updated statistics
    And the demo is complete
