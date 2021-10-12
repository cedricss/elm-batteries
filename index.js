import { createClient } from "@supabase/supabase-js";
import { Elm } from "./src/Main.elm";
import "./scss/style.scss";

if (module.hot) {
  module.hot.dispose(() => {
    window.location.reload();
  });
}

// Copy .env.example to .env and update it with your supabase infos
// Parcel will replace the following env variables with these values
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

const flags = {};

const app = Elm.Main.init({ flags });

async function getBoardPieces() {
  const { data, error } = await supabase.from("board").select();
  app.ports.newBoardPieces.send(data);
}

async function insertBoardPiece(piece) {
  const { data, error } = await supabase.from("board").insert([piece]);
}

getBoardPieces();
