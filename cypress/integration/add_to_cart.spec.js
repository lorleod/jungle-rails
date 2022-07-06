describe('home', () => {
  it('should visit home', () => {
    cy.visit('/')
  });
  it("Clicks on add to cart and cart button count increments", () => {
    cy.get(".btn").first().click({scrollBehavior: "bottom"});
    cy.get(".end-0").should("contain", "1");
  });

})