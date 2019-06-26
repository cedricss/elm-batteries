# Elm Batteries Included

A project template to develop Elm apps with Parcel, Netlify, Tailwind CSS and Cypress.

## Table of contents

- Setup
  - [Generate a new project from this template](#generate-a-new-project)
- Elm + Parcel
  - [Start](#-1-start-your-elm-application)
  - [Build](#-2-build-for-production)
- Elm + Parcel + Netlify
  - [Develop](#-1-develop-with-serverless-functions)
  - [Deploy a preview](#-2-build-for-production-and-deploy-a-preview)
  - [Deploy to production](#-3-deploy-to-production)
  - [Run a live session](#-bonus-run-a-live-session)
- Testing
  - [Run Cypress](#run-cypress)
  - [Run unit and fuzz tests](#run-unit-and-fuzz-tests)
- Styling
  - [Tailwind](#tailwind-and-css-build-tools)
  - [CSS build tools](#tailwind-and-css-build-tools)
- See also
  - [Html meta tags](#meta-tags)
  - [Elm Navigation](#navigation)

## Documentation

## Setup

### Generate a new project

Click the Github green button [Use this template](https://github.com/cedricss/elm-batteries/generate) to generate a new public or private project from [elm-batteries](https://github.com/cedricss/elm-batteries).

In the following documentation, instead of `npm run <command-name>`, you can run `yarn <command-name>` or define short aliases in your terminal.

## Elm + Parcel

### `1` Start your Elm application

```bash
npm run start
```

> ✓ development build and web server with [Parcel](https://parceljs.org/)
> ✓ live reload
> ✓ hot code swapping with [elm-hot](https://github.com/klazuka/elm-hot)

- Web page: http://localhost:1234

### `2` Build for production

```bash
npm run build
```

> ✓ production build with [Parcel](https://parceljs.org/)
> ✓ compilation with the Elm `optimize` flag
> ✓ minification with [`terser`](https://github.com/terser-js/terser)

The JS code from Elm is minified with [special flags](https://elm-lang.org/0.19.0/optimize) that work for Elm apps because they have no side-effects (otherwise it would be unreliable to use such flags).

## Elm + Parcel + Netlify

### `1` Develop with serverless functions

To run serverless functions along your Elm app, run:

```bash
npm run dev
```

> ✓ development build with [Parcel](https://parceljs.org/)
> ✓ web server with Parcel behind [Netlify Dev](https://www.netlify.com/docs/cli/#netlify-dev-beta)
> ✓ serverless functions on your local machine

- Web page: http://localhost:8888
- Serverless function example:
  - http://localhost:8888/.netlify/functions/version
  - source: `functions/version/version.js`

### `2` Build for production and deploy a preview

```bash
npm run deploy
```

> ✓ production build with [Parcel](https://parceljs.org/)
> ✓ compilation with the Elm `optimize` flag
> ✓ minification with [`terser`](https://github.com/terser-js/terser)
> ✓ deployment to a [Netlify](https://www.netlify.com/docs/welcome/) _Live Draft URL_

If you are using Netlify for the first time, run `netlify login` to authenticate (learn more about [Netlify CLI](https://www.netlify.com/docs/cli/)). [Connect a Git repository](https://www.netlify.com/docs/continuous-deployment/) to a Netlify site to keep the two in sync.

If this preview looks good, deploy to production.

### `3` Deploy to production

```bash
npm run deploy:prod
```

> ✓ deployment to production with [Netlify](https://www.netlify.com/docs/welcome/)

### `bonus` Run a live session

To share your development session with a coworker, run:

```bash
npm run dev:live
```

> ✓ development build with [Parcel](https://parceljs.org/)
> ✓ live session with [Netlify Dev](https://www.netlify.com/docs/welcome/)

## Tailwind and CSS build tools

[Tailwind CSS](https://tailwindcss.com/), an utility-first CSS framework, is included along with:

- [`postcss`](https://postcss.org/) (read [`postcss.config.js`](postcss.config.js)),
- [`autoprefixer`](https://github.com/postcss/autoprefixer) to add vendor prefixes,
- [`purgecss`](https://github.com/FullHuman/purgecss) to remove unused selectors,
- and [`cssnano`](https://cssnano.co/) to compress the css (by default with Parcel).

`purgecss` and `cssnano` are used on production mode to minify the css. They are ignored on development mode.

## Testing

### Run Cypress

These tests are in `cypress/integration/*`. To launch Cypress runner app:

```bash
npm run cypress:open
```

Alternatively, to run Cypress tests from the CLI without the GUI:

```bash
npm run cypress
```

The Elm app uses `data-*` attributes to provide context to the selectors and insulate them from CSS or JS changes. [Learn more »](https://docs.cypress.io/guides/references/best-practices.html#Selecting-Elements)

To learn more about Cypress and play with it, [install and start it](https://docs.cypress.io/guides/getting-started/installing-cypress.html#Installing) in a fresh new project folder: it will initialize a `cypress` folder with several examples.

### Run unit and fuzz tests

These tests are in `tests/*`. To start the runner in [watch mode](https://github.com/rtfeldman/node-test-runner#--watch):

```bash
npm run test:watch
```

Alternatively, run it just once:

```bash
npm run test
```

## See also

### Meta tags

[`index.html`](index.html) has meta tags included, like [Twitter Card](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started.html) tags and Open Graph tags. Make sure to update their values and the content preview image (`img/content_preview.jpg`).

### Elm

#### Navigation

- All links in an application create a [`UrlRequest`](https://package.elm-lang.org/packages/elm/browser/latest/Browser#UrlRequest) (read [Browser.application](https://package.elm-lang.org/packages/elm/browser/latest/Browser#application)).
- A [navigation `Key`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Navigation#Key) is needed to create navigation commands that change the URL: it is stored in the `Model`.
- `Nav.pushUrl` changes the address bar without starting a page load.

## Site and sources

- Interactive documentation: [concat.dev/elm](https://concat.dev/elm) (coming soon)
- Project template: [github.com/cedricss/elm-batteries](https://github.com/cedricss/elm-batteries)

## License

MIT
