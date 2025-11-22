/// <reference types="cypress" />
import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Given("I am on the login page", () => {
    cy.visit("/login");
    cy.wait(4000); // Narration: "Opening the hospital appointment system login page"
});

When("I enter {string} and {string}", (email: string, password: string) => {
    cy.wait(3000); // Narration: "Filling in the email address"
    cy.get('input[type="email"]').should('be.visible').clear().type(email);

    cy.wait(3000); // Narration: "Entering the password securely"
    cy.get('input[type="password"]').should('be.visible').clear().type(password);
    cy.wait(1000);
});

When("I click login", () => {
    cy.wait(3000); // Narration: "Submitting the login form"
    cy.get('button[type="submit"]').click();
    cy.wait(2000);
});

Then("I should see the dashboard", () => {
    cy.url().should("include", "/dashboard");
    cy.wait(3000); // Narration: "Login successful"
    cy.wait(3000); // Narration: "Viewing current appointments"
    cy.wait(1000);
});
