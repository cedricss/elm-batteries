module View exposing
    ( container
    , header
    , keyValue
    , navIn
    , navOut
    , notFound
    )

import Css
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (attribute, class, css, href, target)


theme : { headerHeight : Css.Rem }
theme =
    { headerHeight = Css.rem 4 }



-- HEADER


header : List (Html msg) -> Html msg
header items =
    div
        [ class "fixed top-0 inset-x-0 bg-white border-b border-gray-300" -- Tailwind utilities: https://tailwindcss.com
        , css [ Css.height theme.headerHeight ] -- elm-css: https://package.elm-lang.org/packages/rtfeldman/elm-css/latest
        ]
        [ div
            [ class "container mx-auto h-full"
            , class "flex items-center px-6"
            ]
            [ a
                [ attribute "data-test" "logo"
                , class "flex items-center"
                , href "/"
                ]
                [ div
                    [ class "bg-indigo-600 w-4 h-4 rounded-full mr-2" ]
                    []
                , p
                    [ class "font-bold uppercase text-sm text-gray-800" ]
                    [ text "Hello" ]
                ]
            , ul
                [ attribute "data-test" "menu"
                , class "flex-grow"
                , class "flex justify-end"
                ]
                items
            ]
        ]


item : String -> List (Attribute msg) -> Html msg
item name attributes =
    li [ class "mr-6" ] [ a attributes [ text name ] ]


navIn : String -> String -> Html msg
navIn name url =
    item name [ href url ]


navOut : String -> String -> Html msg
navOut name url =
    item name [ href url, target "_blank", class "external" ]



-- CONTAINER


container : List (Html msg) -> Html msg
container content =
    div
        [ attribute "data-test" "content"
        , class "container mx-auto py-10 px-4"
        , css [ Css.marginTop theme.headerHeight ]
        ]
        content



-- DEFAULT PAGES


notFound : List (Html msg)
notFound =
    [ h1
        []
        [ div [ class "text-2xl text-gray-500" ] [ text "404" ]
        , text "Sorry, we could not find this page."
        ]
    , p
        []
        [ a
            [ class "btn", href "/" ]
            [ text "Home" ]
        ]
    ]



-- MISC


keyValue : String -> String -> List (Html msg)
keyValue key value =
    [ span
        [ class "inline-block mr-6 w-12"
        , class "text-gray-600 text-right text-xs uppercase"
        ]
        [ text key ]
    , span
        [ attribute "data-value" key ]
        [ text value ]
    ]
