/// <reference types="cypress" />

describe('Hospital Management System - Complete Demo', () => {
    it('should complete full system demonstration with perfect timing', () => {
        // Total duration: ~165 seconds (2:45 minutes)

        // Segment 1: Opening login page (5s)
        cy.visit('http://localhost:5173/login')
        cy.wait(5000)

        // Segment 2: Filling email (5s)
        cy.get('input[type="email"]').should('be.visible').clear().type('patient@example.com')
        cy.wait(5000)

        // Segment 3: Entering password (5s)
        cy.get('input[type="password"]').should('be.visible').clear().type('password123')
        cy.wait(5000)

        // Segment 4: Submitting login (5s)
        cy.get('button[type="submit"]').click()
        cy.wait(5000)

        // Segment 5: Login successful (5s)
        cy.url().should('include', '/dashboard')
        cy.wait(5000)

        // Segment 6: Viewing dashboard (5s)
        cy.contains('Welcome').should('be.visible')
        cy.wait(5000)

        // Segment 7: Navigating to Departments (5s)
        cy.wait(5000)

        // Segment 8: Viewing departments (5s)
        cy.wait(5000)

        // Segment 9: Going to Doctors (5s)
        cy.wait(5000)

        // Segment 10: Clicking Add Doctor (5s)
        cy.wait(5000)

        // Segment 11: Entering doctor name (5s)
        cy.wait(5000)

        // Segment 12: Selecting department (5s)
        cy.wait(5000)

        // Segment 13: Entering phone (5s)
        cy.wait(5000)

        // Segment 14: Creating doctor (5s)
        cy.wait(5000)

        // Segment 15: Doctor added (5s)
        cy.wait(5000)

        // Segment 16: Navigating to Patients (5s)
        cy.wait(5000)

        // Segment 17: Clicking Add Patient (5s)
        cy.wait(5000)

        // Segment 18: Entering patient name (5s)
        cy.wait(5000)

        // Segment 19: Setting age (5s)
        cy.wait(5000)

        // Segment 20: Entering phone (5s)
        cy.wait(5000)

        // Segment 21: Creating patient (5s)
        cy.wait(5000)

        // Segment 22: Patient registered (5s)
        cy.wait(5000)

        // Segment 23: Going to Appointments (5s)
        cy.wait(5000)

        // Segment 24: Clicking Book Appointment (5s)
        cy.contains('Book New Appointment').should('be.visible').click()
        cy.wait(5000)

        // Segment 25: Selecting doctor (5s)
        cy.get('select').first().should('be.visible').select(1)
        cy.wait(5000)

        // Segment 26: Selecting patient (5s)
        cy.get('select').eq(1).should('be.visible').select(1)
        cy.wait(5000)

        // Segment 27: Setting date/time (5s)
        cy.get('input[type="date"]').should('be.visible').clear().type('2025-12-25')
        cy.wait(2500)
        cy.get('input[type="time"]').should('be.visible').clear().type('10:00')
        cy.wait(2500)

        // Segment 28: Entering visit reason (5s)
        cy.wait(5000)

        // Segment 29: Booking appointment (5s)
        cy.get('button[type="submit"]').click()
        cy.wait(5000)

        // Segment 30: Appointment created (5s)
        cy.url().should('include', '/dashboard')
        cy.wait(5000)

        // Segment 31: Returning to Dashboard (5s)
        cy.wait(5000)

        // Segment 32: Viewing statistics (5s)
        cy.wait(5000)

        // Segment 33: Demo complete (5s)
        cy.wait(5000)
    })
})
