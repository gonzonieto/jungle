describe('Testing Home page', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });

  it('Finds products on the page', () => {
    cy.get('.products article').should('be.visible');
  });

  it('Finds 2 products on the page', () => {
    cy.get('.products article').should('have.length', 2);
  });
});
