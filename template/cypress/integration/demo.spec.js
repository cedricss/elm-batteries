context("Demo", () => {
  /**
    For demo purpose, all tests are in the same file. Feel free to dispatch
    the following contexts in multiple *.spec.js files.
   */
  context("Visit the homepage", () => {
    beforeEach(() => {
      cy.visit("/");
    });

    it("display the content related to this URL", () => {
      /**
        The Elm app uses data-* attributes to provide context to the selectors
        and insulate them from CSS or JS changes.
        https://docs.cypress.io/guides/references/best-practices.html
      */
      cy.get("[data-test=content]").contains("Elm Batteries Included");
    });

    context("Open the demo page from the menu", () => {
      beforeEach(() => {
        cy.get("[data-test=menu]")
          .contains("Demo")
          .click();
      });

      it("change the URL", () => {
        cy.url().should("eq", Cypress.config().baseUrl + "/demo");
      });

      it("update the page with new content", () => {
        cy.get("[data-test=content]").contains("Demo");
      });

      it("go back to the homepage", () => {
        cy.get("[data-test=logo]").click();
        cy.get("[data-test=content]").contains("Elm Batteries Included");
      });
    });
  });

  context("Visit a page that doesn't exist", () => {
    beforeEach(() => {
      cy.visit("/xyz");
    });

    it("display the not found page", () => {
      cy.get("[data-test=content]").contains(
        "Sorry, we could not find this page."
      );
    });
  });

  context("Visit the demo page", () => {
    beforeEach(() => {
      cy.visit("/demo");
      cy.get("[data-test=package]").should(
        "have.attr",
        "data-result",
        "not-asked"
      );
    });

    it("display the content related to this URL", () => {
      cy.get("[data-test=content]").contains("Demo");
    });

    it("decode and show the response", () => {
      cy.server();

      // We stub the call with another author
      cy.route("/.netlify/functions/demo", {
        name: "elm-batteries",
        url: "https://elm-batteries.netlify.com",
        author: "John Doe",
        license: "MIT"
      }).as("demo");

      cy.get("[data-action=fetch-package]").click();

      cy.wait("@demo");
      cy.get("[data-value=author]").contains("John");
    });

    it("show an error if the response is invalid", () => {
      cy.server();

      // We stub the call with an invalid empty response
      cy.route("/.netlify/functions/demo", {}).as("demo");

      cy.get("[data-action=fetch-package]").click();

      cy.wait("@demo");
      cy.get("[data-test=package]").should("have.attr", "data-result", "error");
    });

    /**
      The request in the following test is not stubbed: it guarantees that the
      contract between your Elm app and Netlify is working correctly.
      https://docs.cypress.io/guides/guides/network-requests.html#Testing-Strategies
    */
    it("reach Netlify and retrieve data", () => {
      cy.server();
      cy.route("/.netlify/functions/demo").as("demo");

      cy.get("[data-action=fetch-package]").click();
      cy.get("[data-test=package]").should(
        "have.attr",
        "data-result",
        "loading"
      );

      cy.wait("@demo")
        .its("status")
        .should("equal", 200);

      cy.get("[data-test=package]").should(
        "have.attr",
        "data-result",
        "success"
      );

      cy.get("[data-value=name]").contains("elm-batteries");
      cy.get("[data-value=author]").contains("Cédric Soulas");
      cy.get("[data-value=license]").contains("MIT");
    });
  });
});
