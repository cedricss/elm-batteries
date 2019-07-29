[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![Netlify Status](https://api.netlify.com/api/v1/badges/4954c048-352a-4b1c-bea5-05d4a7c1c4fc/deploy-status)](https://elm-batteries.netlify.com)

# Elm Batteries Included

A project template and a generator to:

- Learn how [Elm](https://elm-lang.org/), [Parcel](https://parceljs.org), [Cypress](https://www.cypress.io) and [Netlify](https://www.netlify.com) work together 😋
- Get started with Elm css, navigation, routes, remote data and JSON decoder

[**Examples ›**](#examples)

## Quick Start

```
npm init elm-batteries ./my-elm-app
```

```
cd my-elm-app && npm run dev
```

or

```
yarn create elm-batteries ./my-elm-app
```

```
cd my-elm-app && yarn dev
```

or [generate from Github ›](#from-github)

## Features

- Local web server and serverless functions
- Hot code and style reloading, keeping app state
- CSS transformations with postcss (autoprefixer, purgecss...)
- Front-end testing
- Optimized and minified production build
- Preview and production deployments

[**Learn more ›**](#table-of-contents)

## Links

- Demo: [elm-batteries.netlify.com/demo](https://elm-batteries.netlify.com/demo)
- Documentation: [Table of contents](https://github.com/cedricss/elm-batteries#table-of-contents)
- Twitter: [@CedricSoulas](https://twitter.com/CedricSoulas)
- Newsletter: [concat.dev/elm](https://concat.dev/elm#subscribe)
- Chat: [Slack](https://elmlang.herokuapp.com/) (ping @CedricSoulas)

## Examples

<h3 align="center">
  <i>The generated <a href="https://elm-lang.org">Elm</a> app. Started with <a href="https://parceljs.org">Parcel</a><br/> behind <a href="https://www.netlify.com/products/dev/">Netlify Dev</a> and tested with <a href="https://www.cypress.io">Cypress</a>:</i>
</h3>

<p align="center">
  <a href="https://elm-batteries.netlify.com/demo">
    <img width="875px" src="https://concat.dev/elm-cypress.png" alt="elm-batteries template demo" />
  </a>
</p>

---

<h3 align="center">
  <br/>
  <i>Usage with <a href="https://www.npmjs.com/get-npm">npm</a> or <a href="https://yarnpkg.com">yarn</a></i>
</h3>

<p align="center">
  <a href="https://elm-batteries.netlify.com/demo">
    <img width="875px" src="https://concat.dev/sneak_peek.png" alt="Website documentation (sneak peek)" />
  </a>
</p>

## Table of contents

- Setup
  - [Generate a new project from this template](#generate-a-new-project)
- Local development
  - [Develop](#develop)
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

## Setup

### Generate a new project

#### From the CLI

<img width="438px" src="https://concat.dev/create-elm-batteries.png" alt="create-elm-batteries cli generator" />

```
npm init elm-batteries ./my-elm-app
```

```
cd my-elm-app
npm run dev
```

or

```
yarn create elm-batteries ./my-elm-app
```

```
cd my-elm-app
yarn dev
```

#### From Github

<img width="401px" src="https://concat.dev/use-this-template.png" alt="Use this Github Template" />

Click [Use this template](https://github.com/cedricss/elm-batteries/generate) to generate a new public or private project from [elm-batteries](https://github.com/cedricss/elm-batteries).

Install the dependencies with `npm install` or `yarn install` and run `npm run dev` or `yarn dev`.

---

💡 In the following documentation, if you use [yarn](https://yarnpkg.com), run `yarn <command-name>` (instead of `npm run <command-name>`). Alternatively, you can define short aliases in your terminal to run these commands.

## Local development

### Develop

To run serverless functions along your Elm app, run

```bash
npm run dev
```

or

```bash
yarn dev
```

Then open [localhost:8888](http://localhost:8888)

> ✓ development build with [Parcel](https://parceljs.org/)<br/>
> ✓ web server with Parcel behind [Netlify Dev](https://www.netlify.com/docs/cli/#netlify-dev-beta)<br/>
> ✓ serverless functions on your local machine<br/>
> ✓ hot code swapping with [elm-hot](https://github.com/klazuka/elm-hot)<br/>

⚠️ Netlify Dev connects to the `1234` default Parcel port. Make sure this port isn't used by another application.

### Develop without Netlify Dev

Read [Elm + Parcel](https://github.com/cedricss/elm-batteries/blob/master/PARCEL.md) to use this project template without Netlify Dev and serverless functions.

### Run a live session

To share your development session with a coworker, run:

```bash
npm run dev:live
```

> ✓ development build with [Parcel](https://parceljs.org/)<br/>
> ✓ live sharing with [Netlify Dev](https://www.netlify.com/docs/welcome/)<br/>

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

The Elm app uses `data-*` attributes to provide context to the selectors and insulate them from CSS or JS changes. [Learn more ›](https://docs.cypress.io/guides/references/best-practices.html#Selecting-Elements)

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

or

```bash
yarn deploy
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

## Links and sources

- Demo: [elm-batteries.netlify.com/demo](https://elm-batteries.netlify.com/demo)
- Documentation: [Table of contents](https://github.com/cedricss/elm-batteries#table-of-contents)
- Twitter: [@CedricSoulas](https://twitter.com/CedricSoulas)
- Newsletter: [concat.dev/elm](https://concat.dev/elm#subscribe)
- Chat: [Slack](https://elmlang.herokuapp.com/) (ping @CedricSoulas)
- Project template: [github.com/cedricss/elm-batteries](https://github.com/cedricss/elm-batteries)
- Built with elm-batteries:
  - [reactive.how/rxjs](https://reactive.how/rxjs)
  - [concat.dev](https://concat.dev)

## License

Authored by [Cédric Soulas](https://twitter.com/CedricSoulas), released under the [MIT](LICENSE) License. Read [LICENSE](LICENSE).
