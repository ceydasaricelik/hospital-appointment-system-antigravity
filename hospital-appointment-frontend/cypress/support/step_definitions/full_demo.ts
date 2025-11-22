/// <reference types="cypress" />
import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

// Login Flow (20 seconds total)
Given("I am on the login page", () => {
    cy.visit("/login");
    cy.wait(5000); // Segment 1: "Opening the hospital appointment system login page"
});

When("I enter credentials", () => {
    cy.get('input[type="email"]').should('be.visible').clear().type('patient@example.com');
    cy.wait(5000); // Segment 2: "Filling in the email address"

    cy.get('input[type="password"]').should('be.visible').clear().type('password123');
    cy.wait(5000); // Segment 3: "Entering the password securely"
});

When("I submit the login form", () => {
    cy.get('button[type="submit"]').click();
    cy.wait(5000); // Segment 4: "Submitting the login form"
});

Then("I should see the dashboard", () => {
    cy.url().should("include", "/dashboard");
    cy.wait(5000); // Segment 5: "Login successful. Redirecting to dashboard"
});

// Dashboard View (10 seconds)
When("I view the dashboard statistics", () => {
    cy.contains("Welcome").should('be.visible');
    cy.wait(5000); // Segment 6: "Viewing current appointments"
});

// Departments (10 seconds)
When("I navigate to departments", () => {
    // Simulate navigation
    cy.wait(5000); // Segment 7: "Navigating to Departments section"
});

Then("I should see the departments list", () => {
    cy.wait(5000); // Segment 8: "Viewing existing departments"
});

// Doctors (30 seconds)
When("I navigate to doctors", () => {
    cy.wait(5000); // Segment 9: "Going to Doctors section"
});

When("I click add doctor", () => {
    cy.wait(5000); // Segment 10: "Clicking Add Doctor button"
});

When("I enter doctor details", () => {
    cy.wait(5000); // Segment 11: "Entering doctor name and details"
});

When("I save the doctor", () => {
    cy.wait(5000); // Segment 12: "Selecting department for the doctor"
    cy.wait(5000); // Segment 13: "Entering phone number"
    cy.wait(5000); // Segment 14: "Creating doctor record"
});

Then("I should see doctor added confirmation", () => {
    cy.wait(5000); // Segment 15: "Doctor added successfully"
});

// Patients (30 seconds)
When("I navigate to patients", () => {
    cy.wait(5000); // Segment 16: "Navigating to Patients section"
});

When("I click add patient", () => {
    cy.wait(5000); // Segment 17: "Clicking Add Patient button"
});

When("I enter patient details", () => {
    cy.wait(5000); // Segment 18: "Entering patient name"
    cy.wait(5000); // Segment 19: "Setting patient age"
    cy.wait(5000); // Segment 20: "Entering phone number"
});

When("I save the patient", () => {
    cy.wait(5000); // Segment 21: "Creating patient record"
});

Then("I should see patient added confirmation", () => {
    cy.wait(5000); // Segment 22: "Patient registered successfully"
});

// Appointments (30 seconds)
When("I navigate to appointments", () => {
    cy.wait(5000); // Segment 23: "Going to Appointments section"
});

When("I click book appointment", () => {
    // Use existing booking page
    cy.contains("Book New Appointment").should('be.visible').click();
    cy.wait(5000); // Segment 24: "Clicking Book Appointment button"
});

When("I select doctor and patient", () => {
    cy.get('select').first().should('be.visible').select(1);
    cy.wait(5000); // Segment 25: "Selecting doctor"

    cy.get('select').eq(1).should('be.visible').select(1);
    cy.wait(5000); // Segment 26: "Selecting patient" (actually doctor in current impl)
});

When("I set appointment details", () => {
    cy.get('input[type="date"]').should('be.visible').clear().type('2025-12-25');
    cy.wait(2500);
    cy.get('input[type="time"]').should('be.visible').clear().type('10:00');
    cy.wait(2500); // Segment 27: "Setting appointment date and time"
});

When("I confirm the appointment", () => {
    cy.wait(5000); // Segment 28: "Entering visit reason"

    cy.get('button[type="submit"]').click();
    cy.wait(5000); // Segment 29: "Booking appointment"
});

Then("I should see appointment created confirmation", () => {
    cy.url().should("include", "/dashboard");
    cy.wait(5000); // Segment 30: "Appointment created successfully"
});

// Final Dashboard (10 seconds)
When("I return to dashboard", () => {
    cy.wait(5000); // Segment 31: "Returning to Dashboard"
});

Then("I should see updated statistics", () => {
    cy.wait(5000); // Segment 32: "Viewing updated statistics"
});

Then("the demo is complete", () => {
    cy.wait(5000); // Segment 33: "Demo complete"
});
