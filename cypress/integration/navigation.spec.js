context("Homepage", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("display the homepage content", () => {
    /**
      The Elm app uses data-* attributes to provide context to the selectors
      and insulate them from CSS or JS changes.
      https://docs.cypress.io/guides/references/best-practices.html
    */
    cy.get("[data-test=content]").contains("Elm Batteries Included");
  });

  context("open the API demo page", () => {
    beforeEach(() => {
      cy.get("[data-test=menu]")
        .contains("API demo")
        .click();
    });

    it("display the API demo content", () => {
      cy.get("[data-test=content]").contains("API demo");
    });

    it("go back to the homepage", () => {
      cy.get("[data-test=logo]").click();
      cy.get("[data-test=content]").contains("Elm Batteries Included");
    });
  });
});
