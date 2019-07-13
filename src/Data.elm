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
    Decode.succeed Package
        |> required "name" string
        |> required "url" string
        |> required "author" string
        |> required "license" string
