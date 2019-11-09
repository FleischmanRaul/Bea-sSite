module Main exposing (..)

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src, style)
import Html.Styled.Events exposing (onClick)
import Random



---- MODEL ----


type alias Model =
    { counter : Int
    , menuOn : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { counter = 1, menuOn = False }, Cmd.none )



---- UPDATE ----


type Msg
    = Roll
    | NewFace Int
    | TogleMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace model.menuOn
            , Cmd.none
            )

        TogleMenu ->
            ( Model model.counter (not model.menuOn)
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


beaLogo =
    img [ src "./bea_logo.png", css [ margin (px 100), height (vmin 60), width (vmin 60), maxWidth (vw 100) ] ] []


row =
    div [ css [ maxWidth (vw 100) ] ]
        [ img [ src "./pink.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./blue.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./gray.jpeg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./pink.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./blue.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./gray.jpeg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./pink.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./blue.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./gray.jpeg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        ]


view : Model -> Html Msg
view model =
    nav [ css [ cursor crosshair ] ]
        [ menu model
        , beaLogo
        , row
        ]


menuHoverButton : Html.Styled.Html Msg
menuHoverButton =
    a
        [ onClick TogleMenu
        , css
            [ hover
                [ backgroundColor (rgb 0 0 0)
                , color (rgb 255 255 255)
                ]
            , padding (px 10)
            ]
        ]
        [ text "Open/Close " ]


menu : Model -> Html.Styled.Html Msg
menu model =
    if model.menuOn then
        div
            [ css [ padding (px 10), fontSize (px 24) ]
            , style "-webkit-user-select" "none"
            , style "-moz-user-select" "none"
            , style "-ms-user-select" "none"
            , style "user-select" "none"
            ]
            [ menuHoverButton
            , a
                [ onClick Roll
                , css
                    [ margin (px 10)
                    , hover
                        [ backgroundColor (rgb 0 0 0)
                        , color (rgb 255 255 255)
                        ]
                    ]
                ]
                [ text "home" ]
            , a
                [ onClick Roll
                , css
                    [ margin (px 10)
                    , hover
                        [ backgroundColor (rgb 0 0 0)
                        , color (rgb 255 255 255)
                        ]
                    ]
                ]
                [ text "contact" ]
            , a
                [ onClick Roll
                , css
                    [ margin (px 10)
                    , hover
                        [ backgroundColor (rgb 0 0 0)
                        , color (rgb 255 255 255)
                        ]
                    ]
                ]
                [ text "projects" ]
            ]

    else
        div [ css [ padding (px 10), fontSize (px 24) ] ] [ menuHoverButton ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view >> toUnstyled
        }


{-| A plain old record holding a couple of theme colors.
-}
theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "11111"
    , secondary = rgb 150 140 230
    }


{-| A reusable button which has some styles pre-applied to it.
-}
btn : List (Attribute msg) -> List (Html msg) -> Html msg
btn =
    styled button
        [ margin (px 12)
        , color (rgb 50 50 50)
        , hover
            [ backgroundColor theme.primary
            , textDecoration underline
            ]
        ]
