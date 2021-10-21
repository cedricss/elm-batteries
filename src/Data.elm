module Data exposing (Package, Piece, Side(..), encodePiece, flip, packageDecoder, pieceDecoder)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as Encode


type alias Package =
    { name : String
    , url : String
    , author : String
    , license : String
    }


type Side
    = Front
    | Back


type alias Piece =
    { position : Int
    , side : Side
    }


flip : Piece -> Piece
flip piece =
    case piece.side of
        Back ->
            { piece | side = Front }

        Front ->
            { piece | side = Back }



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
        |> required "position" int
        |> required "side" (Decode.map stringToSide string)


stringToSide side =
    if side == "BACK" then
        Back

    else
        Front


sideToString side =
    case side of
        Back ->
            "BACK"

        Front ->
            "FRONT"


encodePiece : Piece -> Encode.Value
encodePiece piece =
    Encode.object
        [ ( "position", Encode.int piece.position )
        , ( "side", Encode.string (sideToString piece.side) )
        ]
