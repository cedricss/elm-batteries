module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (attribute, class)
import Markdown
import Url exposing (Url)


type alias Flags =
    { readme : String }



-- MODEL


type alias Model =
    { key : Nav.Key
    , readme : String
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


view : Model -> Browser.Document Msg
view model =
    { title = title
    , body = body model
    }


body : Model -> List (Html Msg)
body model =
    [ Markdown.toHtml
        [ attribute "data-test" "markdown-content"
        , class "markdown"
        ]
        model.readme
    ]


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
      , readme = flags.readme
      , state = Demo
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
