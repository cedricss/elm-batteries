import { createClient } from "@supabase/supabase-js";

import { Elm } from "./src/Main.elm";
import "./scss/style.scss";

if (module.hot) {
  module.hot.dispose(() => {
    window.location.reload();
  });
}

const flags = {};

const app = Elm.Main.init({ flags });

// Copy .env.example to .env and update it with your supabase infos
// Parcel will replace the following env variables with these values
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

const boardSubscription = supabase
  .from("board")
  .on("INSERT", (payload) => {
    console.log("Change received!", payload);
    app.ports.newBoardPiece.send(payload.new);
  })
  .subscribe();

async function getBoardPieces() {
  const { data, error } = await supabase
    .from("board")
    .select()
    .order("created_at", { ascending: true });
  data.map(app.ports.newBoardPiece.send);
}

async function insertBoardPiece(piece) {
  const { data, error } = await supabase.from("board").insert([piece]);
  console.log(data);
  console.log(error);
}

app.ports.insertPiece.subscribe(insertBoardPiece);

getBoardPieces();
