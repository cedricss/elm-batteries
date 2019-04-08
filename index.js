import { Elm } from "./src/Main.elm";
import "./scss/style.scss";
import { readFileSync } from "fs";

if (module.hot) {
  module.hot.dispose(() => {
    window.location.reload();
  });
}

var flags = {
  readme: readFileSync("README.md", "utf-8")
};

var app = Elm.Main.init({ flags });
