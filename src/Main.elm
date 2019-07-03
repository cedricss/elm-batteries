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


title : String
title =
    "Elm Batteries Included!"



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = title
    , body = [ body model |> toUnstyled ]
    }


body : Model -> Html Msg
body model =
    div
        [ attribute "data-test" "content"
        , class "content text-center"
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
