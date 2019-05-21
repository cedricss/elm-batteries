context("Markdown", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("display the content of README.md", () => {
    cy.get('[data-test="markdown-content"]').contains("Table of contents");
  });
});
