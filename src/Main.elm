module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Data
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, attribute, class, css, disabled, href, src)
import Html.Styled.Events exposing (onClick)
import Http
import Markdown
import RemoteData exposing (RemoteData)
import Route exposing (Route(..))
import Url exposing (Url)
import View exposing (navIn, navOut)


type alias Flags =
    {}



-- MODEL


type alias Model =
    { key : Nav.Key
    , route : Route.Route
    , package : RemoteData Http.Error Data.Package
    }


type Msg
    = -- Message naming conventions: https://youtu.be/w6OVDBqergc
      BrowserChangedUrl Url
    | UserClickedLink Browser.UrlRequest
    | UserClickedPackageButton
    | ServerRespondedWithPackage (Result Http.Error Data.Package)


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
        , navIn "API demo" "/api/demo"
        , navOut "Twitter" "https://twitter.com/CedricSoulas"
        , navOut "Github" "https://github.com/cedricss/elm-batteries"
        ]
    , View.container <|
        case model.route of
            ApiDemo ->
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
        , src "/content_preview.jpg"
        , alt "Commands cheat sheet"
        ]
        []
    ]


viewDemo : Model -> List (Html Msg)
viewDemo model =
    let
        content attributes =
            ul <|
                [ attribute "data-test" "package"
                , class "mt-8 flex flex-col justify-center max-w-2xl h-48"
                , class "bg-transition rounded"
                , class "pl-10 font-semibold leading-loose"
                ]
                    ++ attributes

        item key value =
            li [] (View.keyValue key value)

        fetchButton =
            button
                [ class "w-56"
                , attribute "data-action" "fetch-package"
                , onClick UserClickedPackageButton
                ]
                [ text "Fetch package.json" ]
    in
    [ h1 [] [ text "API demo" ]
    , div [] <|
        case model.package of
            RemoteData.Success p ->
                [ fetchButton
                , content
                    [ attribute "data-result" "success"
                    , class "bg-gray-300"
                    ]
                    [ item "name" p.name
                    , item "url" p.url
                    , item "author" p.author
                    , item "license" p.license
                    ]
                ]

            RemoteData.NotAsked ->
                [ fetchButton
                , content
                    [ attribute "data-result" "not-asked"
                    , class "bg-white"
                    ]
                    []
                ]

            RemoteData.Loading ->
                [ button
                    [ class "w-56 cursor-wait"
                    , disabled True
                    ]
                    [ text "Loading..." ]
                , content
                    [ attribute "data-result" "loading"
                    , class "bg-gray-500"
                    ]
                    []
                ]

            RemoteData.Failure _ ->
                [ fetchButton
                , content
                    [ attribute "data-result" "error"
                    , class "bg-red-500 p-12 text-white text-center"
                    ]
                    [ li [] [ text "Oops! Something went wrong..." ] ]
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

        UserClickedPackageButton ->
            ( { model | package = RemoteData.Loading }
            , Http.get
                { url = "/.netlify/functions/demo"
                , expect =
                    Http.expectJson
                        ServerRespondedWithPackage
                        Data.packageDecoder
                }
            )

        ServerRespondedWithPackage result ->
            ( { model | package = RemoteData.fromResult result }
            , Cmd.none
            )


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        route =
            Route.fromUrl url
    in
    ( { key = key
      , route = route
      , package = RemoteData.NotAsked
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
