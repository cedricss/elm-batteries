# Elm Batteries Included!

### Table of contents

- [Parcel](#parcel)
- [Elm](#elm)
- Tailwind
- Purgecss
- Postcss
- Cypress
- Netlify
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

## See also

### Meta tags

[`index.html`](index.html) has meta tags included, like [Twitter Card](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started.html) tags and Open Graph tags. Make sure to update their values and the content preview image (`img/content_preview.jpg`)

# License

MIT
