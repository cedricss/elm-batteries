## Elm + Parcel

### Start your Elm application

```bash
npm run start
```

> ✓ development build and web server with [Parcel](https://parceljs.org/)<br/>
> ✓ hot code swapping with [elm-hot](https://github.com/klazuka/elm-hot)<br/>

- Web page: http://localhost:1234

### Build for production

```bash
npm run build
```

> ✓ production build with [Parcel](https://parceljs.org/)<br/>
> ✓ compilation with the Elm `optimize` flag<br/>
> ✓ minification with [`terser`](https://github.com/terser-js/terser)<br/>

💡 The JS code from Elm is minified with [special flags](https://elm-lang.org/0.19.0/optimize) that work for Elm apps because they have no side-effects (otherwise it would be unreliable to use such flags).

## Testing

Edit `cypress.json` to use the `1234` Parcel dev server port (instead of the `8888` Netlify Dev port):

```json
{
  "baseUrl": "http://localhost:1234"
}
```

Learn more in [README.md](README.md).
