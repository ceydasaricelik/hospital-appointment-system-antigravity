/// <reference types="cypress" />
import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

When("I navigate to the booking page", () => {
    cy.wait(3000); // Narration: "Clicking on Book New Appointment button"
    cy.contains("Book New Appointment").should('be.visible').click();
    cy.wait(2000);
});

When("I select a department, doctor, date, and time", () => {
    cy.wait(3000); // Narration: "Selecting the medical department"
    cy.get('select').first().should('be.visible').select(1);

    cy.wait(3000); // Narration: "Choosing an available doctor"
    cy.get('select').eq(1).should('be.visible').select(1);

    cy.wait(3000); // Narration: "Picking the appointment date and time"
    cy.get('input[type="date"]').should('be.visible').clear().type('2025-12-25');
    cy.wait(1500);
    cy.get('input[type="time"]').should('be.visible').clear().type('10:00');
    cy.wait(2000);
});

When("I submit the booking form", () => {
    cy.wait(3000); // Narration: "Submitting the appointment booking form"
    cy.get('button[type="submit"]').click();
    cy.wait(3000);
});

Then("I should see the new appointment on the dashboard", () => {
    cy.url().should("include", "/dashboard");
    cy.wait(3000); // Narration: "Appointment created successfully"
    cy.wait(3000); // Narration: "Verifying the new appointment appears"
    cy.contains("2025-12-25").should('be.visible');
    cy.wait(2000);
});
