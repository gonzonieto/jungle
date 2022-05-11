describe('Testing product details page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('Loads a product page from the homepage', () => {
    cy.get('.products article').first().click();
    cy.get('section.products-show header.page-header');
    cy.get('article.product-detail img.main-img');
    cy.get('article.product-detail div.quantity');
    cy.get('article.product-detail div.price');
    cy.get('article.product-detail button.btn');
  });
});
