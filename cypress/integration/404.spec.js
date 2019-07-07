context("Not found", () => {
  beforeEach(() => {
    cy.visit("/xyz");
  });

  it("display the not found page", () => {
    cy.get("[data-test=content]").contains(
      "Sorry, we could not find this page."
    );
  });
});
