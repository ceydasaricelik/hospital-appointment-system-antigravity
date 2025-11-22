// cypress/support/e2e.ts
import './commands';

before(() => {
    // Inject cursor style
    const style = document.createElement('style');
    style.innerHTML = `
    #virtual-cursor {
      position: fixed;
      width: 20px;
      height: 20px;
      background-color: rgba(255, 0, 0, 0.7);
      border-radius: 50%;
      pointer-events: none;
      z-index: 99999;
      transition: all 0.5s ease-in-out;
      top: 0;
      left: 0;
      opacity: 0;
      box-shadow: 0 0 10px rgba(0,0,0,0.5);
    }
    #virtual-cursor::after {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 4px;
      height: 4px;
      background: white;
      border-radius: 50%;
      transform: translate(-50%, -50%);
    }
  `;
    document.head.appendChild(style);

    // Inject cursor element
    const cursor = document.createElement('div');
    cursor.id = 'virtual-cursor';
    document.body.appendChild(cursor);
});

beforeEach(() => {
    // Ensure cursor exists in the body of the app (if it gets cleared)
    cy.document().then((doc) => {
        if (!doc.getElementById('virtual-cursor')) {
            const cursor = doc.createElement('div');
            cursor.id = 'virtual-cursor';
            doc.body.appendChild(cursor);
        }
    });
});
