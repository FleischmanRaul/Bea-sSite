module Main exposing (..)

import Browser exposing (UrlRequest(..))
import Color
import Css exposing (..)
import Ease
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Projects
import SmoothScroll exposing (Config, scrollToWithOptions)
import Task



---- MODEL ----


defaultConfig : Config
defaultConfig =
    { offset = 12
    , speed = 40
    , easing = Ease.outQuint
    }


type Page
    = Home
    | Contact


type alias Model =
    { menuOn : Bool
    , hoverOn : Bool
    , hoveredPicture : Int
    , openedModal : Int
    , bodyCss : List Style
    }


init : ( Model, Cmd Msg )
init =
    ( { menuOn = False
      , hoverOn = False
      , hoveredPicture = 0
      , openedModal = 0
      , bodyCss = [ cursor crosshair, overflow hidden, overflowY hidden ]
      }
    , Cmd.none
    )


type Msg
    = TogleMenu
    | CloseModal
    | OpenModal Int
    | HoverOn Int
    | HoverOff
    | DoNothing
    | JumpTo String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TogleMenu ->
            ( { model | menuOn = not model.menuOn }
            , Cmd.none
            )

        CloseModal ->
            ( { model | openedModal = 0, bodyCss = [ cursor crosshair ] }
            , Cmd.none
            )

        OpenModal id ->
            ( { model | openedModal = id, bodyCss = [ cursor crosshair, overflow hidden, overflowY hidden, pointerEvents none ] }
            , Cmd.none
            )

        HoverOn pictureId ->
            ( { model | hoveredPicture = pictureId }
            , Cmd.none
            )

        HoverOff ->
            ( { model | hoveredPicture = 0 }
            , Cmd.none
            )

        DoNothing ->
            ( model
            , Cmd.none
            )

        JumpTo id ->
            ( model
            , Task.attempt (always DoNothing) (scrollToWithOptions defaultConfig id)
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


view : Model -> Html Msg
view model =
    nav
        [ css model.bodyCss
        , style "-webkit-user-select" "none"
        , style "-moz-user-select" "none"
        , style "-ms-user-select" "none"
        , style "user-select" "none"
        ]
        [ menu model
        , beaLogo model
        , projectTable model
        , about
        , projectModal model
        , footer
        ]


beaLogo : Model -> Html Msg
beaLogo model =
    div [ css [ displayFlex, alignItems center, justifyContent center, flexDirection row, verticalAlign center ] ]
        [ if model.menuOn then
            img [ src "./cross.png", css [ height (vmin 4), width (vmin 4), marginRight (vmin 25) ], onClick TogleMenu ] []

          else
            img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), marginRight (vmin 25) ], onClick TogleMenu ] []
        , img [ src "./bea_logo.png", css [ margin (vmin 15), height (vmin 60), width (vmin 60), maxWidth (vw 100) ] ] []
        , img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), marginLeft (vmin 25), visibility hidden ] ] []
        ]


projectTable : Model -> Html Msg
projectTable model =
    div [ css [ maxWidth (vw 100), fontSize (px 0) ], id "projects" ]
        [ project model "./heron/heron_landing.png" "HERON COLLECTION" 1
        , project model "./blue.jpg" "2 project" 2
        , project model "./gray.jpeg" "3 project" 3
        , project model "./pink.jpg" "4 project" 4
        , project model "./blue.jpg" "5 project" 5
        , project model "./gray.jpeg" "6 project" 6
        , project model "./pink.jpg" "7 project" 7
        ]


project : Model -> String -> String -> Int -> Html Msg
project model picturePath description id =
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vmax 30), width (vmax 30) ], onMouseOver <| HoverOn id, onMouseOut HoverOff, onClick <| OpenModal id ]
        [ img [ src picturePath, css [ margin zero, height (vmax 30), width (vmax 30), maxWidth (vw 100), borderRadius (rem 0.2) ] ] []
        , if model.hoveredPicture == id then
            p [ css [ position absolute, backgroundColor Color.transparent, width (vmax 30), height (vmax 4), bottom (Css.em -1), borderRadius (rem 0.2), color Color.white, fontSize (px 20), display Css.table ] ]
                [ p [ css [ display tableCell, verticalAlign middle, fontWeight bold ] ] [ text description ]
                ]

          else
            p [] []
        ]


projectModal : Model -> Html Msg
projectModal model =
    if model.openedModal == 1 then
        Projects.projectOne
            { closeModal = CloseModal
            }

    else if model.openedModal == 2 then
        Projects.projectTwo
            { closeModal = CloseModal
            }

    else
        div [] []


about : Html Msg
about =
    div [ css [ margin (vw 12), width (vw 76), lineHeight (Css.em 2), fontSize (px 18) ], id "about" ] [ Projects.aboutText ]


menu : Model -> Html.Styled.Html Msg
menu model =
    if model.menuOn then
        div
            [ css [ fontSize (px 24), paddingTop (px 20) ]
            ]
            [ a
                [ css
                    [ margin (px 30)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Home" ]
            , a
                [ onClick (JumpTo "projects")
                , css
                    [ margin (px 30)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Projects" ]
            , a
                [ onClick (JumpTo "about")
                , css
                    [ margin (px 30)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "About" ]
            , a
                [ onClick TogleMenu
                , css
                    [ margin (px 30)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Contact" ]
            ]

    else
        div [ css [ fontSize (px 24), visibility hidden ] ] [ text "Beata Csaka Design" ]


footer : Html Msg
footer =
    nav [ css [ padding (px 10), fontSize (px 12), backgroundColor (rgb 0 0 0), color (rgb 255 255 255), height (vmin 15), displayFlex, alignItems center, justifyContent center, flexDirection column ] ]
        [ div [] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        , img [ src "./bea_logo_white.png", css [ margin (px 20), height (vmin 6), width (vmin 6), maxWidth (vw 10) ] ] []
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
