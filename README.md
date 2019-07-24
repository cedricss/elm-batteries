[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![Netlify Status](https://api.netlify.com/api/v1/badges/4954c048-352a-4b1c-bea5-05d4a7c1c4fc/deploy-status)](https://elm-batteries.netlify.com)

# Elm Batteries Included

A project template and a generator to:

- Develop Elm apps with Parcel, Netlify, Tailwind CSS and Cypress
- Learn how these delightful web technologies work together 😋
- Get started with Elm css, navigation, routes, remote data and JSON decoder

---

<p align="center">
  <i>The generated <a href="https://elm-lang.org">Elm</a> app started with <a href="https://parceljs.org">Parcel</a><br/> behind <a href="https://www.netlify.com/products/dev/">Netlify Dev</a> and tested with <a href="https://www.cypress.io">Cypress</a>:</i>
</p>

<p align="center">
  <a href="https://elm-batteries.netlify.com/demo">
    <img width="875px" src="https://concat.dev/elm-cypress.png" alt="elm-batteries template demo" />
  </a>
</p>

## Links

- Demo: [elm-batteries.netlify.com/demo](https://elm-batteries.netlify.com/demo)
- Documentation: [concat.dev/elm](https://concat.dev/elm)
- News and support:
  - [Twitter](https://twitter.com/CedricSoulas)
  - [Mailing list](https://concat.dev/elm#subscribe)
  - [Slack](https://elmlang.herokuapp.com/) (ping @CedricSoulas)

## Features

- Elm app with css, navigation, routes, remote data and JSON decoder
- Local web server and serverless functions
- Hot code and style reloading, keeping app state
- Front-end testing
- Optimized and minified production build
- Live, preview and production deployments

![Website documentation (sneak peek)](https://concat.dev/sneak_peek.png)

## Table of contents

- Setup
  - [Generate a new project from this template](#generate-a-new-project)
- Local development
  - [Develop](#develop) (Elm + Parcel)
  - [Develop with serverless functions](#develop-with-serverless-functions) (Elm + Parcel + Netlify Dev)
  - [Run a live session](#run-a-live-session)
- Testing
  - [Run Cypress](#run-cypress)
  - [Run unit and fuzz tests](#run-unit-and-fuzz-tests)
- Production build and deployment
  - [Build for production and deploy a preview](#build-for-production-and-deploy-a-preview)
  - [Deploy to production](#deploy-to-production)
  - [Going further](#going-further)
- Designing
  - [Tailwind](#designing)
  - [CSS build tools](#designing)
- See also
  - [Html meta tags](#meta-tags)
  - [Elm Navigation](#navigation)

## Documentation

## Setup

### Generate a new project

#### From the CLI

```
npm init elm-batteries my-elm-project
```

<p align="center">
    <img width="816px" src="https://concat.dev/create-elm-batteries.png" alt="create-elm-batteries cli generator" />
</p>

#### From Github

Click the Github green button [Use this template](https://github.com/cedricss/elm-batteries/generate) to generate a new public or private project from [elm-batteries](https://github.com/cedricss/elm-batteries).

Install the dependencies:

```
npm install
```

💡 In the following documentation, if you use [yarn](https://yarnpkg.com), run `yarn <command-name>` (instead of `npm run <command-name>`). Alternatively, you can define short aliases in your terminal to run these commands.

## Local development

### Develop (Elm + Parcel)

Read [Elm + Parcel](PARCEL.md) to use this project template without Netlify Dev and serverless functions.

### Develop with serverless functions (Elm + Parcel + Netlify Dev)

To run serverless functions along your Elm app, run:

```bash
npm run dev
```

> ✓ development build with [Parcel](https://parceljs.org/)<br/>
> ✓ web server with Parcel behind [Netlify Dev](https://www.netlify.com/docs/cli/#netlify-dev-beta)<br/>
> ✓ serverless functions on your local machine<br/>
> ✓ hot code swapping with [elm-hot](https://github.com/klazuka/elm-hot)<br/>

- Web page: http://localhost:8888
- Serverless function example:
  - http://localhost:8888/.netlify/functions/version
  - source: `functions/version/version.js`

### Run a live session

To share your development session with a coworker, run:

```bash
npm run dev:live
```

> ✓ development build with [Parcel](https://parceljs.org/)<br/>
> ✓ live session with [Netlify Dev](https://www.netlify.com/docs/welcome/)<br/>

## Testing

### Run Cypress

These tests are in `cypress/integration/*`. [Start your Elm app](#1-develop-with-serverless-functions) then launch the Cypress runner app:

```bash
npm run cypress:open
```

If you open one test from the list of spec files then you should see your application loaded:

![Cypress runner app](https://concat.dev/elm-cypress.png)

Alternatively, to run Cypress tests from the CLI without the GUI:

```bash
npm run cypress
```

The Elm app uses `data-*` attributes to provide context to the selectors and insulate them from CSS or JS changes. [Learn more »](https://docs.cypress.io/guides/references/best-practices.html#Selecting-Elements)

To learn more about Cypress and play with it, [install and start it](https://docs.cypress.io/guides/getting-started/installing-cypress.html#Installing) in a fresh new project folder: it will initialize a `cypress` folder with several examples.

### Run unit and fuzz tests

Install [elm-test](https://github.com/rtfeldman/node-test-runner).

These tests are in `tests/*`. To start the runner in [watch mode](https://github.com/rtfeldman/node-test-runner#--watch):

```bash
npm run test:watch
```

Alternatively, run it just once:

```bash
npm run test
```

## Production build and deployment

### Build for production and deploy a preview

```bash
npm run deploy
```

> ✓ production build with [Parcel](https://parceljs.org/)<br/>
> ✓ compilation with the Elm `optimize` flag<br/>
> ✓ minification with [`terser`](https://github.com/terser-js/terser)<br/>
> ✓ deployment to a [Netlify](https://www.netlify.com/docs/welcome/) _Live Draft URL_<br/>

💡 If you are using Netlify for the first time, run `netlify login` to authenticate (learn more about [Netlify CLI](https://www.netlify.com/docs/cli/)).

💡 The JS code from Elm is minified with [special flags](https://elm-lang.org/0.19.0/optimize) that work for Elm apps because they have no side-effects (otherwise it would be unreliable to use such flags).

If this preview looks good, deploy to production.

### Deploy to production

```bash
npm run deploy:prod
```

> ✓ deployment to production with [Netlify](https://www.netlify.com/docs/welcome/)<br/>

### Going further

`deploy` commands are great when rapidly iterating. Consider also setting up [continuous deployment with Netlify »](https://www.netlify.com/docs/continuous-deployment/).

## Designing

[Tailwind CSS](https://tailwindcss.com/), an utility-first CSS framework, is included along with:

- [`postcss`](https://postcss.org/) (read [`postcss.config.js`](postcss.config.js)),
- [`autoprefixer`](https://github.com/postcss/autoprefixer) to add vendor prefixes,
- [`purgecss`](https://github.com/FullHuman/purgecss) to remove unused selectors,
- and [`cssnano`](https://cssnano.co/) to compress the css (by default with Parcel).

`purgecss` and `cssnano` are used on production mode to minify the css. They are ignored on development mode.

## See also

### Meta tags

[`index.html`](index.html) has meta tags included, like [Twitter Card](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started.html) tags and Open Graph tags. Make sure to update their values and the content preview image (`img/content_preview.jpg`).

### Elm

#### Navigation

- All links in an application create a [`UrlRequest`](https://package.elm-lang.org/packages/elm/browser/latest/Browser#UrlRequest) (read [Browser.application](https://package.elm-lang.org/packages/elm/browser/latest/Browser#application)).
- A [navigation `Key`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Navigation#Key) is needed to create navigation commands that change the URL: it is stored in the `Model`.
- `Nav.pushUrl` changes the address bar without starting a page load.

## Site and sources

- Documentation: [concat.dev/elm/batteries](https://concat.dev/elm)
- Project template: [github.com/cedricss/elm-batteries](https://github.com/cedricss/elm-batteries)
- News and support:
  - [Twitter](https://twitter.com/CedricSoulas)
  - [Mailing list](https://concat.dev/elm#subscribe)
  - [Slack](https://elmlang.herokuapp.com/) (ping @CedricSoulas)
- Built with elm-batteries:
  - [reactive.how/rxjs](https://reactive.how/rxjs)
  - [concat.dev](https://concat.dev)

## License

Authored by [Cédric Soulas](https://twitter.com/CedricSoulas), released under the [MIT](LICENSE) License.
