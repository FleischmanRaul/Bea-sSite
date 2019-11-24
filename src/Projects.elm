module Projects exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Dom as Dom
import Color
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Task


type alias Messages message =
    { closeModal : message
    }


projectOne messages =
    div [ css [ backgroundColor Color.transparent, position fixed, width (vw 100), top zero, height (vh 100), overflow scroll, overflowY auto, overflowX hidden ], onClick messages.closeModal ]
        [ div [ css [ width (vw 70), backgroundColor Color.heronBlack, marginLeft (vw 15), fontSize (px 0), pointerEvents none ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./heron/1.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./heron/2.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), maxWidth (vw 100), fontSize (px 18), color Color.paleYellow, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
                [ p [ css [] ] [ text "The name of the collection is HERON (a representative element for the Art Deco style and movement), including niche objects, gaining its main inspiration from Art Deco." ]
                , p [ css [] ] [ text "The collection brings back its items from obsolescence, and gives them a design purpose, but a functional one aswell. \nThe collection consists of 4 objects: a chaise lounge, a bar cart, a set of auxiliary tables and a high stand for plants. The approached shapes recreate the Art Deco style through linear geometry, but breaks the symmetry, characteristic for it, while preserving its well-known elegance. High-quality materials have been used, combining Art Deco with contemporary notes, the collection's pieces getting a modern and stylish feel." ]
                ]
            , img [ src "./heron/4.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./heron/5.png", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15) ] ] []
            , img [ src "./heron/6.png", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15) ] ] []
            , img [ src "./heron/7.jpg", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15), marginBottom zero ] ] []
            , img [ src "./heron/8.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


projectTwo messages =
    div [ css [ backgroundColor Color.white, position fixed, left (vw 10), width (vw 80), top (vh 10), overflow auto, borderRadius (rem 0.2) ] ]
        [ div []
            [ h1 [ css [ display Css.table, margin (px 100) ] ]
                [ span [ css [ display tableCell, verticalAlign middle ] ] [ text "Header" ]
                , img [ src "./cross.png", css [ display tableCell, verticalAlign middle, left (px 100), height (px 16), width (px 16) ], onClick messages.closeModal ] []
                ]
            ]
        , div [ css [ margin (px 100), textAlign left ] ]
            [ text
                "Second one"
            ]
        , div [ css [ paddingTop (vh 2) ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]
