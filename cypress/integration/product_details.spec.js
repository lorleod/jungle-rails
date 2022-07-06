describe('home', () => {
  it('should visit home', () => {
    cy.visit('/')
  });
  it("Clicks on product and loads product url", () => {
    cy.get("article").first().click()
    cy.url().should('include', '/products/')
  });
})