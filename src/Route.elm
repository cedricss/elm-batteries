module Route exposing
    ( Route(..)
    , fromUrl
    )

import Url
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, top)


type Route
    = ApiDemo
    | Home
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map Home (s "index.html")
        , map ApiDemo (s "demo")

        --  Add more routes like this:
        --  , map Comment (s "user" </> string </> s "comment" </> int)
        --  , map BlogQuery (s "blog" <?> Query.string "q")
        --  Learn more: https://guide.elm-lang.org/webapps/url_parsing.html
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    Parser.parse parser url
        |> Maybe.withDefault NotFound
