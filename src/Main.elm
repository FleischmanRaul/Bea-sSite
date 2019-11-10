module Main exposing (..)

-- import Action

import Browser exposing (UrlRequest(..))
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src, style)
import Html.Styled.Events exposing (onClick)



---- MODEL ----


black : Color
black =
    rgb 0 0 0


white : Color
white =
    rgb 255 255 255


type Page
    = Home
    | Contact


type alias Model =
    { counter : Int
    , menuOn : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { counter = 1
      , menuOn = False
      }
    , Cmd.none
    )


type Msg
    = TogleMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TogleMenu ->
            ( Model model.counter (not model.menuOn)
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


beaLogo : Model -> Html Msg
beaLogo model =
    div []
        [ menuHoverButton model
        , img [ src "./bea_logo.png", css [ margin (px 100), height (vmin 60), width (vmin 60), maxWidth (vw 100) ] ] []
        ]


row : Html Msg
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
    nav
        [ css [ cursor crosshair ]
        , style "-webkit-user-select" "none"
        , style "-moz-user-select" "none"
        , style "-ms-user-select" "none"
        , style "user-select" "none"
        ]
        [ menu model
        , beaLogo model
        , row
        , about
        , footer
        ]


menuHoverButton : Model -> Html.Styled.Html Msg
menuHoverButton model =
    if model.menuOn then
        img [ src "./cross.png", css [ height (vmin 4), width (vmin 4) ], onClick TogleMenu ] []

    else
        img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), left (vw 10) ], onClick TogleMenu ] []


about : Html Msg
about =
    text "Bea vagyok"


menu : Model -> Html.Styled.Html Msg
menu model =
    if model.menuOn then
        div
            [ css [ padding (px 10), fontSize (px 24) ]
            ]
            [ a
                [ onClick TogleMenu
                , css
                    [ margin (px 10)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Home" ]
            , a
                [ onClick TogleMenu
                , css
                    [ margin (px 10)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Projects" ]
            , a
                [ onClick TogleMenu
                , css
                    [ margin (px 10)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "About" ]
            , a
                [ onClick TogleMenu
                , css
                    [ margin (px 10)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Contact" ]
            ]

    else
        div [ css [ padding (px 10), fontSize (px 24) ] ] [ text "Menu should be here" ]


footer : Html Msg
footer =
    nav [ css [ padding (px 10), fontSize (px 12), backgroundColor (rgb 0 0 0), color (rgb 255 255 255) ] ]
        [ div [] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        , img [ src "./bea_logo_white.png", css [ margin (px 10), height (vmin 6), width (vmin 6), maxWidth (vw 10) ] ] []
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view >> toUnstyled
        }
