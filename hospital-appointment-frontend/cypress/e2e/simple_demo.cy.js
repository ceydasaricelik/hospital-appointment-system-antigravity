/// <reference types="cypress" />

describe('Hospital Appointment System - Simple Demo', () => {
    it('should complete appointment booking flow', () => {
        // Segment 1: Opening (3s)
        cy.visit('http://localhost:5173/login')
        cy.wait(3000)

        // Segment 2: Entering email (3s)
        cy.get('input[type="email"]').should('be.visible').clear().type('patient@example.com')
        cy.wait(3000)

        // Segment 3: Entering password (3s)
        cy.get('input[type="password"]').should('be.visible').clear().type('password123')
        cy.wait(3000)

        // Segment 4: Clicking login (3s)
        cy.get('button[type="submit"]').click()
        cy.wait(3000)

        // Segment 5: Login successful (3s)
        cy.url().should('include', '/dashboard')
        cy.wait(3000)

        // Segment 6: Viewing appointments (3s)
        cy.contains('Welcome').should('be.visible')
        cy.wait(3000)

        // Segment 7: Clicking Book New Appointment (3s)
        cy.contains('Book New Appointment').should('be.visible').click()
        cy.wait(3000)

        // Segment 8: Selecting department (3s)
        cy.get('select').first().should('be.visible').select(1)
        cy.wait(3000)

        // Segment 9: Selecting doctor (3s)
        cy.get('select').eq(1).should('be.visible').select(1)
        cy.wait(3000)

        // Segment 10: Entering date (3s)
        cy.get('input[type="date"]').should('be.visible').clear().type('2025-12-25')
        cy.wait(3000)

        // Segment 11: Entering time (3s)
        cy.get('input[type="time"]').should('be.visible').clear().type('14:30')
        cy.wait(3000)

        // Segment 12: Submitting form (3s)
        cy.get('button[type="submit"]').click()
        cy.wait(3000)

        // Segment 13: Appointment created (3s)
        cy.url().should('include', '/dashboard')
        cy.wait(3000)

        // Segment 14: Viewing details (3s)
        cy.contains('2025-12-25').should('be.visible')
        cy.contains('14:30').should('be.visible')
        cy.wait(3000)

        // Segment 15: Demo complete (3s)
        cy.wait(3000)
    })
})
