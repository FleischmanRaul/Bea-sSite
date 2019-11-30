module Contact exposing (contactBody)

import Color
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)
import Html.Styled.Events exposing (onClick)


contactBody : Html msg
contactBody =
    div []
        [ div []
            [ input [] []
            , input [] []
            ]
        , div [] [ textarea [] [] ]
        , div [] [ button [ css [ color (rgb 50 50 50), backgroundColor Color.paleYellow, width <| px 100, height <| px 30 ] ] [] ]
        ]
