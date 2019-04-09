# Elm Batteries Included!

### Table of contents

- [Parcel](#parcel)
- [Elm](#elm)
- [Tailwind and CSS build tools](#tailwind-and-css-build-tools)
- [elm-test and Cypress](#elm-test-and-cypress)
- [Netlify](#netlify)
- [See also](#see-also)

# Batteries

## Parcel

### Start

```
npm run start
```

This runs `npx parcel index.html` (read [`package.json`](package.json)). Hot code swapping in Elm works with [`elm-hot`](https://github.com/klazuka/elm-hot).

### Build

```
npm run build
```

This runs `npx parcel build index.html`.

`*.elm` files are:

- Compiled with the Elm `optimize` flag.
- Minified with [`terser`](https://github.com/terser-js/terser) and the [recommended flags](https://elm-lang.org/0.19.0/optimize) for Elm apps, which have no side-effects.

## Elm

### Navigation

- All links in an application create a [`UrlRequest`](https://package.elm-lang.org/packages/elm/browser/latest/Browser#UrlRequest) (read [Browser.application](https://package.elm-lang.org/packages/elm/browser/latest/Browser#application)).
- A [navigation `Key`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Navigation#Key) is needed to create navigation commands that change the URL: it is stored in the `Model`.
- `Nav.pushUrl` changes the address bar without starting a page load.

## Tailwind and CSS build tools

[Tailwind CSS](https://tailwindcss.com/), an utility-first CSS framework, is included along with:

- [`postcss`](https://postcss.org/) (read [`postcss.config.js`](postcss.config.js)),
- [`autoprefixer`](https://github.com/postcss/autoprefixer) to add vendor prefixes,
- [`purgecss`](https://github.com/FullHuman/purgecss) to remove unused selectors,
- and [`cssnano`](https://cssnano.co/) to compress the css (by default with `parcel`).

`purgecss` and `cssnano` are used on production mode (`npm run build`) to minify the css. They are ignored on development mode (`npm run start`).

## elm-test and Cypress

TODO

## Netlify

```
npm run deploy
```

This builds your project in _production_ mode and deploy to a Netlify _Live Draft URL_.
If this draft looks good, deploy to production:

```
npm run deploy:prod
```

**Notes:**

- If you are using Netlify for the first time, run `netlify login` to authenticate (learn more about [Netlify CLI](https://www.netlify.com/docs/cli/))
- [Connect a Git repository to a Netlify site](https://www.netlify.com/docs/continuous-deployment/) to keep the two in sync

## See also

### Meta tags

[`index.html`](index.html) has meta tags included, like [Twitter Card](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started.html) tags and Open Graph tags. Make sure to update their values and the content preview image (`img/content_preview.jpg`).

# Site and source code

- [github.com/cedricss/elm-batteries](https://github.com/cedricss/elm-batteries)
- [elm-batteries.netlify.com](http://elm-batteries.netlify.com)

# License

MIT
