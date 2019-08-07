module Data exposing (Package, packageDecoder)

import Json.Decode as Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (required)


type alias Package =
    { name : String
    , url : String
    , author : String
    , license : String
    }


packageDecoder : Decoder Package
packageDecoder =
    -- Build JSON decoders using the pipeline (|>) operator:
    -- https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/1.0.0/
    -- See also bool, float, int, list, nullable, etc. in:
    -- https://package.elm-lang.org/packages/elm/json/latest/Json-Decode
    Decode.succeed Package
        |> required "name" string
        |> required "url" string
        |> required "author" string
        |> required "license" string
