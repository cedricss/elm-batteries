context("Markdown", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("display the homepage content", () => {
    cy.get("[data-test=content]").contains("Elm Batteries Included");
  });
});
