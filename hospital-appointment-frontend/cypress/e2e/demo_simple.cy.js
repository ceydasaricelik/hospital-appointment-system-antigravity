/// <reference types="cypress" />

describe('Hospital Appointment Demo', () => {
    it('should complete full appointment flow', () => {
        // Login
        cy.visit('http://localhost:5173/login')
        cy.wait(4000)

        cy.get('input[type="email"]').should('be.visible').clear().type('patient@example.com')
        cy.wait(3000)

        cy.get('input[type="password"]').should('be.visible').clear().type('password123')
        cy.wait(3000)

        cy.get('button[type="submit"]').click()
        cy.wait(3000)

        // Verify dashboard
        cy.url().should('include', '/dashboard')
        cy.wait(3000)

        cy.contains('Welcome').should('be.visible')
        cy.wait(3000)

        // Navigate to booking
        cy.contains('Book New Appointment').should('be.visible').click()
        cy.wait(3000)

        // Select department
        cy.get('select').first().should('be.visible').select(1)
        cy.wait(3000)

        // Select doctor
        cy.get('select').eq(1).should('be.visible').select(1)
        cy.wait(3000)

        // Enter date and time
        cy.get('input[type="date"]').should('be.visible').clear().type('2025-12-25')
        cy.wait(1500)

        cy.get('input[type="time"]').should('be.visible').clear().type('10:00')
        cy.wait(3000)

        // Submit
        cy.get('button[type="submit"]').click()
        cy.wait(3000)

        // Verify success
        cy.url().should('include', '/dashboard')
        cy.wait(3000)

        cy.contains('2025-12-25').should('be.visible')
        cy.wait(3000)
    })
})
