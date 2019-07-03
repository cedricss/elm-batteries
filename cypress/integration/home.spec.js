context("Home page", () => {
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
});
