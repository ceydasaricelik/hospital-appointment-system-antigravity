/// <reference types="cypress" />

describe('Hospital Appointment System - Production Demo', () => {
    it('should complete appointment booking with perfect audio sync', () => {

        // Segment 1: Opening (4s) - Wait for narration FIRST
        cy.wait(4000)
        cy.visit('http://localhost:5173/login')

        // Segment 2: Entering email (4s) - Narration THEN action
        cy.wait(4000)
        cy.get('input[type="email"]').should('be.visible').clear().type('patient@example.com')

        // Segment 3: Entering password (4s)
        cy.wait(4000)
        cy.get('input[type="password"]').should('be.visible').clear().type('password123')

        // Segment 4: Clicking login (4s)
        cy.wait(4000)
        cy.get('button[type="submit"]').click()

        // Segment 5: Login successful (4s)
        cy.wait(4000)
        cy.url().should('include', '/dashboard')

        // Segment 6: Viewing appointments (4s)
        cy.wait(4000)
        cy.contains('Welcome').should('be.visible')

        // Segment 7: Clicking Book New Appointment (4s)
        cy.wait(4000)
        cy.contains('Book New Appointment').should('be.visible').click()

        // Segment 8: Selecting department (4s)
        cy.wait(4000)
        cy.get('select').first().should('be.visible').select(1)

        // Segment 9: Selecting doctor (4s)
        cy.wait(4000)
        cy.get('select').eq(1).should('be.visible').select(1)

        // Segment 10: Entering date (4s)
        cy.wait(4000)
        cy.get('input[type="date"]').should('be.visible').clear().type('2025-12-25')

        // Segment 11: Entering time (4s)
        cy.wait(4000)
        cy.get('input[type="time"]').should('be.visible').clear().type('14:30')

        // Segment 12: Submitting form (4s)
        cy.wait(4000)
        cy.get('button[type="submit"]').click()

        // Segment 13: Appointment created (4s)
        cy.wait(4000)
        cy.url().should('include', '/dashboard')

        // Segment 14: Viewing details (4s)
        cy.wait(4000)
        cy.contains('2025-12-25').should('be.visible')
        cy.contains('14:30').should('be.visible')

        // Segment 15: Demo complete (4s)
        cy.wait(4000)
    })
})
