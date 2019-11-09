port module Stylesheets exposing (CssClasses(..), CssIds(..), helpers, main)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.File exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "src/style.css", Css.File.compile [ css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles


type CssClasses
    = NavBar


type CssIds
    = Page


appNamespace =
    "App"


helpers =
    withNamespace appNamespace


css =
    (stylesheet << namespace appNamespace)
        [ body
            [ overflowX auto
            , minWidth (px 1280)
            ]
        , id Page
            [ backgroundColor (rgb 200 128 64)
            , color (hex "CCFFFF")
            , width (pct 100)
            , height (pct 100)
            , boxSizing borderBox
            , padding (px 8)
            , margin zero
            ]
        , class NavBar
            [ margin zero
            , padding zero
            , children
                [ li
                    [ display inlineBlock |> important
                    , color primaryAccentColor
                    ]
                ]
            ]
        ]


primaryAccentColor =
    hex "ccffaa"
