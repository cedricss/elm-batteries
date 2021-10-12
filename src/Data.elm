module Data exposing (Package, Piece, packageDecoder, piecesDecoder)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (required)


type alias Package =
    { name : String
    , url : String
    , author : String
    , license : String
    }


type alias Piece =
    { x : Int
    , y : Int
    }



-- Build JSON decoders using the pipeline (|>) operator:
-- https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/1.0.0/
-- See also bool, float, int, list, nullable, etc. in:
-- https://package.elm-lang.org/packages/elm/json/latest/Json-Decode


packageDecoder : Decoder Package
packageDecoder =
    Decode.succeed Package
        |> required "name" string
        |> required "url" string
        |> required "author" string
        |> required "license" string


pieceDecoder : Decoder Piece
pieceDecoder =
    Decode.succeed Piece
        |> required "x" int
        |> required "y" int


piecesDecoder : Decoder (List Piece)
piecesDecoder =
    Decode.list pieceDecoder
