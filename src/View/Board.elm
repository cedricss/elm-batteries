module View.Board exposing (view)

import Css exposing (..)
import Data
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (attribute, class, css, href, target)
import Html.Styled.Events exposing (onClick)


pieceDimension =
    50


view : (Data.Piece -> msg) -> List Data.Piece -> Html msg
view updatePieceMsg board =
    div
        [ css
            [ position relative
            , width <| px <| pieceDimension * 8
            , height <| px <| pieceDimension * 8
            , displayFlex
            , flexWrap wrap
            , border3 (px 3) solid (hex "000")
            , boxSizing contentBox
            , borderRadius (px 8)
            , overflow hidden
            ]
        ]
    <|
        List.map (viewPiece updatePieceMsg) board


viewPiece : (Data.Piece -> msg) -> Data.Piece -> Html msg
viewPiece updatePieceMsg piece =
    div
        [ css
            [ position relative
            , height (px pieceDimension)
            , width (px pieceDimension)
            , cursor pointer
            , hover [ outline3 (px 2) solid (hex "ee0"), zIndex (int 10) ]
            , case piece.side of
                Data.Front ->
                    backgroundColor (hex "fff")

                Data.Back ->
                    backgroundColor (hex "000")
            ]
        , onClick (updatePieceMsg piece)
        ]
        []
