module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div, h1, text)
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


title =
    "Elm Batteries Included!"


view : Model -> Browser.Document Msg
view model =
    { title = title
    , body = body model
    }


body : Model -> List (Html Msg)
body model =
    [ h1
        []
        [ text title ]
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
      , state = Demo
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
