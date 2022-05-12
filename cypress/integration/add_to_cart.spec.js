describe('Testing add-to-cart functionality', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('Has an empty cart on page load', () => {
    cy.get('.navbar a.nav-link').should('contain', '0');
  });

  it('Has one item in cart after clicking an add to cart button', () => {
    cy.get('.products button.btn').first().click();
    cy.get('.navbar a.nav-link').should('contain', '1');
  });

  // it('Has two items in cart after clicking an add to cart button a second time', () => {
  //   cy.get('.products button.btn').first().click();
  //   cy.get('.navbar a.nav-link').should('contain', '1');
  // });
});
