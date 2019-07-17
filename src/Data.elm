module Data exposing (Package, packageDecoder)

import Json.Decode as Decode
    exposing
        ( Decoder
        , decodeString
        , float
        , int
        , list
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (hardcoded, optional, required)


type alias Package =
    { name : String
    , url : String
    , author : String
    , license : String
    }


packageDecoder : Decoder Package
packageDecoder =
    -- Build JSON decoders using the pipeline (|>) operator.
    -- Learn more: https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/1.0.0/
    Decode.succeed Package
        |> required "name" string
        |> required "url" string
        |> required "author" string
        |> required "license" string
