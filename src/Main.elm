port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Data
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (attribute, class, disabled, href)
import Html.Styled.Events exposing (onClick)
import Http
import Json.Decode
import Json.Encode
import List.Extra
import RemoteData exposing (RemoteData)
import Route exposing (Route(..))
import Url exposing (Url)
import View exposing (navIn, navOut)
import View.Board


type alias Flags =
    {}



-- MODEL


type alias Model =
    { key : Nav.Key
    , route : Route.Route
    , board : List Data.Piece
    , package : RemoteData Http.Error Data.Package
    }


type Msg
    = -- Message naming conventions: https://youtu.be/w6OVDBqergc
      BrowserChangedUrl Url
    | UserClickedLink Browser.UrlRequest
    | UserClickedPackageButton
    | UserClickedPiece Data.Piece
    | ServerRespondedWithPackage (Result Http.Error Data.Package)
    | DatabaseRespondedWithPiece Json.Encode.Value


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


project : { description : String, title : String, url : String }
project =
    { title = "Elm Batteries Included!"
    , description = """
        Develop Elm apps with Parcel, Netlify, Tailwind CSS and Cypress.
        Learn how these delightful web technologies work together.
        Get started with Elm navigation, routes, remote data and JSON decoder
      """
    , url = "https://github.com/cedricss/elm-batteries#elm-batteries-included"
    }


view : Model -> Browser.Document Msg
view model =
    { title = project.title
    , body = [ body model |> div [] |> toUnstyled ]
    }


body : Model -> List (Html Msg)
body model =
    [ View.header
        [ navIn "Home" "/"
        , navIn "API Demo" "/demo/api"
        , navIn "Database Demo" "/demo/database"
        , navOut "Documentation" "https://concat.dev/elm"
        , navOut "Twitter" "https://twitter.com/CedricSoulas"
        , navOut "Github" "https://github.com/cedricss/elm-batteries"
        ]
    , View.container <|
        case model.route of
            ApiDemo ->
                viewApiDemo model

            DatabaseDemo ->
                viewDatabaseDemo model

            Home ->
                viewHome model

            NotFound ->
                View.notFound
    ]


viewHome : Model -> List (Html Msg)
viewHome model =
    [ h1 [] [ text "Elm Batteries Included" ]
    , p
        [ class "max-w-2xl text-xl mb-4" ]
        [ text project.description ]
    , ul
        [ class "text-xl" ]
        [ li [] [ a [ href "/demo" ] [ text "Try the demo ›" ] ]
        , li [] [ a [ href project.url ] [ text "Read the documentation ›" ] ]
        ]
    ]


viewApiDemo : Model -> List (Html Msg)
viewApiDemo model =
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
    [ h1 [] [ text "API Demo" ]
    , h2 [] [ text "Serverless Lambda function on Netlify" ]
    , p
        [ class "max-w-xl text-xl mb-8" ]
        [ text "The demo function has a faux 500ms delay to simulate a slower connection and illustrate the loading state. "
        , a
            [ href "https://github.com/cedricss/elm-batteries/blob/master/functions/demo/demo.js#L5" ]
            [ text "Learn more ›" ]
        ]
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


viewDatabaseDemo : Model -> List (Html Msg)
viewDatabaseDemo model =
    [ h1 [] [ text "Database Demo" ]
    , h2 [] [ text "Persistent data and real-time with Supabase" ]
    , View.Board.view UserClickedPiece model.board
    ]



-- UPDATE


setPiece piece model =
    { model
        | board =
            List.Extra.setAt piece.position piece model.board
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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

        UserClickedPiece piece ->
            let
                flippedPiece =
                    Data.flip piece
            in
            ( setPiece flippedPiece model, insertPiece (Data.encodePiece flippedPiece) )

        DatabaseRespondedWithPiece value ->
            case Json.Decode.decodeValue Data.pieceDecoder value of
                Ok piece ->
                    ( setPiece piece model, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        ServerRespondedWithPackage result ->
            ( { model | package = RemoteData.fromResult result }
            , Cmd.none
            )


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        route =
            Route.fromUrl url

        makePiece n =
            { position = n, side = Data.Front }
    in
    ( { key = key
      , route = route
      , board = List.range 0 (8 * 8) |> List.map makePiece
      , package = RemoteData.NotAsked
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    newBoardPiece DatabaseRespondedWithPiece


port newBoardPiece : (Json.Encode.Value -> msg) -> Sub msg


port insertPiece : Json.Encode.Value -> Cmd msg
