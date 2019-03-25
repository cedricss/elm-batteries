import { Elm } from "./src/Main.elm";
import "./scss/style.scss";

if (module.hot) {
  module.hot.dispose(() => {
    window.location.reload();
  });
}

var flags = {};
var app = Elm.Main.init({ flags });
