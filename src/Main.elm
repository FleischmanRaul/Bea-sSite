module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Color
import Css exposing (..)
import Ease
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Projects
import SmoothScroll exposing (Config, scrollToWithOptions)
import Task



---- MODEL ----


defaultConfig : Config
defaultConfig =
    { offset = 12
    , speed = 30
    , easing = Ease.outQuint
    }


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


menuCss =
    hidden


type Msg
    = TogleMenu
    | CloseModal
    | OpenModal Int
    | HoverOn Int
    | HoverOff
    | DoNothing
    | JumpTo String
    | SendMail


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
            ( { model | openedModal = id, bodyCss = [ cursor crosshair, height <| vh 100, overflow hidden, pointerEvents none ] }
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

        SendMail ->
            ( model
            , Nav.load "mailto:beaa.csaka@gmail.com"
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
        , projectModal model
        , contact model
        , footer
        ]


contact : Model -> Html Msg
contact model =
    div [ id "contact", css [ displayFlex, alignItems center, justifyContent center, flexDirection column, margin (vmin 10) ] ]
        [ div
            [ css
                [ width <| px 150
                , height <| px 20
                , margin <| px 20
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            , onClick SendMail
            ]
            [ text "Send me a mail" ]
        ]


beaLogo : Model -> Html Msg
beaLogo model =
    div [ css [ displayFlex, alignItems center, justifyContent center, flexDirection row, verticalAlign center ] ]
        [ div [ onClick TogleMenu ]
            [ if model.menuOn then
                img [ src "./cross.png", css [ height (vmin 4), width (vmin 4) ] ] []

              else
                img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4) ] ] []
            ]
        , img [ src "./bea_logo.png", css [ marginLeft <| vw 15, marginTop <| vh 10, marginRight <| vw 15, marginBottom <| vh 20, height (vmin 60), width (vmin 60), maxWidth (vw 100) ], onClick <| OpenModal 7 ] []
        , img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), visibility hidden ] ] []
        ]


projectTable : Model -> Html Msg
projectTable model =
    div [ css [ maxWidth (vw 100), fontSize (px 0) ], id "projects" ]
        [ project model "./heron/heron_landing.png" "HERON COLLECTION" 1
        , project model "./indagra/indagra_landing.png" "INDAGRA" 2
        , project model "./astro/astro_main.png" "ASTRO CARDS" 3
        , project model "./bosch/bosch_main.png" "BOSCH WALL ART" 4
        , project model "./plasmo/plasmo_main.png" "PLASMO LIFE" 5
        , project model "./dochia/dochia_main.png" "CASA LU' DOCHIA" 6
        , project model "./gray.jpeg" "6 project" 8
        , project model "./pink.jpg" "7 project" 9
        , project model "./blue.jpg" "9 project" 10
        ]


project : Model -> String -> String -> Int -> Html Msg
project model picturePath description id =
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vmax 30), width (vmax 30) ], onMouseOver <| HoverOn id, onMouseOut HoverOff, onClick <| OpenModal id ]
        [ img [ src picturePath, css [ margin zero, height (vmax 30), width (vmax 30), maxWidth (vw 100), borderRadius (rem 0.2) ] ] []
        , if model.hoveredPicture == id then
            p [ css [ position absolute, backgroundColor Color.transparent, width (vmax 30), height (vmax 4), bottom (Css.em -1), borderRadius (rem 0.2), color Color.white, fontSize (px 16), display Css.table, letterSpacing (px 2) ] ]
                [ p [ css [ display tableCell, verticalAlign middle, fontWeight bold ] ] [ text description ]
                ]

          else
            p [] [ ]
        ]


projectModal : Model -> Html Msg
projectModal model =
    if model.openedModal == 1 then
        Projects.heron
            { closeModal = CloseModal
            }

    else if model.openedModal == 2 then
        Projects.indagra
            { closeModal = CloseModal
            }

    else if model.openedModal == 3 then
        Projects.astroCards
            { closeModal = CloseModal
            }

    else if model.openedModal == 4 then
        Projects.bosch
            { closeModal = CloseModal
            }

    else if model.openedModal == 5 then
        Projects.plasmo
            { closeModal = CloseModal
            }

    else if model.openedModal == 6 then
        Projects.dochia
            { closeModal = CloseModal
            }

    else if model.openedModal == 7 then
        Projects.about
            { closeModal = CloseModal
            }

    else
        div [] []




menu : Model -> Html.Styled.Html Msg
menu model =
    div
        [ css
            [ fontSize (px 20)
            , paddingTop (vh 10)
            , if model.menuOn then
                visibility visible

              else
                visibility hidden
            ]
        ]
        [ a
            [ onClick <| JumpTo "projects"
            , css
                [ margin (px 30)
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "HOME" ]
        , a
            [ onClick <| JumpTo "projects"
            , css
                [ margin (px 30)
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "PROJECTS" ]
        , a
            [ onClick <| OpenModal 7
            , css
                [ margin (px 30)
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "ABOUT" ]
        , a
            [ onClick <| JumpTo "contact"
            , css
                [ margin (px 30)
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "CONTACT" ]
        ]


footer : Html Msg
footer =
    nav [ css [ padding (px 10), fontSize (px 12), backgroundColor Color.black, color Color.white, height (vmin 15), displayFlex, alignItems center, justifyContent center, flexDirection column ] ]
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
