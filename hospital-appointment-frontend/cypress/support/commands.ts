/// <reference types="cypress" />

// Add custom commands for visual cursor
declare global {
    namespace Cypress {
        interface Chainable {
            visualClick(): Chainable<Element>;
            visualType(text: string): Chainable<Element>;
            visualHover(): Chainable<Element>;
        }
    }
}

const moveCursor = ($el: JQuery<HTMLElement>) => {
    const rect = $el[0].getBoundingClientRect();
    const cursor = Cypress.$('#virtual-cursor');

    if (cursor.length) {
        cursor.css({
            top: `${rect.top + rect.height / 2}px`,
            left: `${rect.left + rect.width / 2}px`,
            opacity: '1'
        });
        cy.wait(500);
    }
};

const zoomIn = () => {
    cy.document().then((doc) => {
        doc.body.style.transition = "transform 0.5s ease";
        doc.body.style.transform = "scale(1.2)";
        doc.body.style.transformOrigin = "center center";
    });
    cy.wait(500);
};

const zoomOut = () => {
    cy.document().then((doc) => {
        doc.body.style.transform = "scale(1)";
    });
    cy.wait(500);
};

Cypress.Commands.add('visualClick', { prevSubject: 'element' }, (subject) => {
    moveCursor(subject);
    zoomIn();
    cy.wrap(subject).click();
    cy.wait(200);
    zoomOut();
});

Cypress.Commands.add('visualType', { prevSubject: 'element' }, (subject, text) => {
    moveCursor(subject);
    zoomIn();
    cy.wrap(subject).type(text);
    cy.wait(200);
    zoomOut();
});

Cypress.Commands.add('visualHover', { prevSubject: 'element' }, (subject) => {
    moveCursor(subject);
    zoomIn();
    cy.wait(500);
    zoomOut();
});

export { };
