module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, attribute, class, css, href, src)
import Html.Styled.Events exposing (onClick)
import Markdown
import Url exposing (Url)


type alias Flags =
    {}



-- MODEL


type alias Model =
    { key : Nav.Key
    , state : State
    }


type State
    = Demo


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- VIEW


title : String
title =
    "Elm Batteries Included!"


theme : { headerHeight : Rem }
theme =
    { headerHeight = rem 4 }


view : Model -> Browser.Document Msg
view model =
    { title = title
    , body = [ body model |> toUnstyled ]
    }


body : Model -> Html Msg
body model =
    div
        []
        [ viewHeader
        , div
            [ class "container mx-auto flex-wrap-reverse flex" ]
            [ viewSidebar model
            , viewContent model
            ]
        ]


viewHeader : Html msg
viewHeader =
    div
        [ class "fixed top-0 inset-x-0 bg-white border-b border-gray-300"
        , css [ height theme.headerHeight ]
        ]
        [ div
            [ class "container mx-auto h-full"
            , class "flex items-center px-6"
            ]
            [ p
                [ class "font-semibold uppercase text-sm text-gray-600" ]
                [ text "header" ]
            ]
        ]


viewSidebar : Model -> Html Msg
viewSidebar model =
    div
        [ class "w-full lg:w-1/4 xl:w-1/5" ]
        [ nav
            [ class "overflow-y-auto lg:py-4 sticky"
            , css
                [ height <| calc (vh 100) minus theme.headerHeight
                , top theme.headerHeight
                ]
            ]
            [ p
                [ class "font-semibold uppercase text-sm text-gray-600"
                , class "px-6 py-4 h-full"
                , class "lg:rounded bg-indigo-100"
                ]
                [ text "sidebar" ]
            ]
        ]


viewContent : Model -> Html Msg
viewContent model =
    div
        [ attribute "data-test" "content"
        , class "content text-center"
        , class "w-full lg:w-3/4 xl:w-4/5"
        , class "min-h-screen w-full"
        , css [ marginTop theme.headerHeight ]
        ]
        [ h1
            []
            [ text "Elm Batteries Included" ]
        , img
            [ src "content_preview.jpg"
            , alt "Commands cheat sheet"
            ]
            []
        , p
            []
            [ text "Sneak peek of the documentation website, coming soon \u{1F91E}" ]
        , p
            [ class "font-semibold" ]
            [ a
                [ href "https://twitter.com/CedricSoulas" ]
                [ text "@CedricSoulas" ]
            , text " | "
            , a
                [ href "https://github.com/cedricss/elm-batteries" ]
                [ text "github.com/cedricss/elm-batteries" ]
            ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noChange =
            ( model, Cmd.none )
    in
    case msg of
        ChangedUrl _ ->
            noChange

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        NoOp ->
            noChange


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , state = Demo
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
