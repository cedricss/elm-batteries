module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, attribute, class, css, href, src)
import Html.Styled.Events exposing (onClick)
import Markdown
import Route exposing (Route(..))
import Url exposing (Url)
import View exposing (navIn, navOut)


type alias Flags =
    {}



-- MODEL


type alias Model =
    { key : Nav.Key
    , route : Route.Route
    }


type Msg
    = BrowserChangedUrl Url
    | UserClickedLink Browser.UrlRequest


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , onUrlRequest = UserClickedLink
        , onUrlChange = BrowserChangedUrl
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- VIEW


title : String
title =
    "Elm Batteries Included!"


view : Model -> Browser.Document Msg
view model =
    { title = title
    , body = [ body model |> div [] |> toUnstyled ]
    }


body : Model -> List (Html Msg)
body model =
    [ View.header
        [ navIn "Home" "/"
        , navIn "API demo" "/demo"
        , navOut "Twitter" "https://twitter.com/CedricSoulas"
        , navOut "Github" "https://github.com/cedricss/elm-batteries"
        ]
    , View.container <|
        case model.route of
            Demo ->
                viewDemo model

            Home ->
                viewHome model

            NotFound ->
                View.notFound
    ]


viewContent : List (Html Msg) -> Html Msg
viewContent content =
    div
        [ class "content text-center" ]
        content


viewHome : Model -> List (Html Msg)
viewHome model =
    [ h1
        [ class "text-center" ]
        [ text "Elm Batteries Included" ]
    , p
        [ class "text-center" ]
        [ text "Sneak peek of the documentation website, coming soon \u{1F91E}" ]
    , img
        [ class "max-w-4xl mx-auto"
        , src "content_preview.jpg"
        , alt "Commands cheat sheet"
        ]
        []
    ]


viewDemo : Model -> List (Html Msg)
viewDemo model =
    [ h1
        []
        [ text "API demo" ]
    ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noChange =
            ( model, Cmd.none )
    in
    case msg of
        BrowserChangedUrl url ->
            ( { model | route = Route.fromUrl url }
            , Cmd.none
            )

        UserClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , route = Route.fromUrl url
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
