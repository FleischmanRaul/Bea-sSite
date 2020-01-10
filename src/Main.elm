module Main exposing (..)

import Browser
import Browser.Events
import Browser.Navigation as Nav
import Browser.Dom as Dom
import Color
import Css exposing (..)
import Ease
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Projects
import SmoothScroll exposing (Config, scrollToWithOptions)
import Task
import Url



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
    , width : Int 
    , height : Int
    , mobile : Bool
    , key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { menuOn = False
      , hoverOn = False
      , hoveredPicture = 0
      , openedModal = 0
      , bodyCss = [ cursor crosshair, overflow hidden, overflowY hidden ]
      , width = 0
      , height = 0
      , mobile = False
      , key = key
      , url = url
      }
    , Task.perform windwoResizeFromVp Dom.getViewport
    )


windwoResizeFromVp : Dom.Viewport -> Msg
windwoResizeFromVp vp =
    WindowResize
        (floor vp.viewport.width)
        (floor vp.viewport.height)

type Msg
    = TogleMenu
    | CloseModal
    | OpenModal Int String
    | HoverOn Int
    | HoverOff
    | DoNothing
    | JumpTo String
    | SendMail
    | WindowResize Int Int
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TogleMenu ->
            ( { model | menuOn = not model.menuOn }
            , Cmd.none
            )

        CloseModal ->
            ( { model | openedModal = 0, bodyCss = [ cursor crosshair, overflowY hidden ] }
            , Nav.pushUrl model.key "/home"
            )

        OpenModal id url ->
            ( { model | openedModal = id, bodyCss = [ cursor crosshair, height <| vh 100, overflow hidden, overflowY hidden, pointerEvents none ] }
            , Nav.pushUrl model.key url
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

        WindowResize w h ->
            ( { model | height = h, width = w, mobile = (w < 600) }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Cmd.none )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize WindowResize



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    let
        body =
            nav
                [ css model.bodyCss
                , style "-webkit-user-select" "none"
                , style "-moz-user-select" "none"
                , style "-ms-user-select" "none"
                , style "user-select" "none"
                ]
                [ beaLogo model
                , projectTable model
                , projectModal model
                , contact model
                , footer
                ]
    in
        { body = [ Html.Styled.toUnstyled body ]
        , title = "Beata Csaka"
        }
     

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
        [ menu model
        , div [ onClick TogleMenu ]
            [ if model.menuOn then
                img [ src "./cross.png", css [ height (vmin 4), width (vmin 4) ] ] []

              else
                img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4) ] ] []
            ]
        , img [ src "./bea_logo.png", css [ marginLeft <| vw 15, marginTop <| vh 10, marginRight <| vw 15, marginBottom <| vh 10, height (vw 35), width (vw 35), maxWidth (vw 100) ], onClick <| OpenModal 7 "about"] []
        , img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), visibility hidden ] ] []
        ]


projectTable : Model -> Html Msg
projectTable model =
    div [ css [ maxWidth (vw 100), fontSize (px 0) ], id "projects" ]
        [ project model "./heron/heron_landing.png" "HERON COLLECTION" 1 "heron"
        , project model "./indagra/indagra_landing.png" "INDAGRA" 2 "indagra"
        , project model "./astro/astro_main.png" "ASTRO CARDS" 3 "astro"
        , project model "./bosch/bosch_main.png" "BOSCH WALL ART" 4 "bosch"
        , project model "./plasmo/plasmo_main.png" "PLASMO LIFE" 5 "plasmo"
        , project model "./dochia/dochia_main.png" "CASA LU' DOCHIA" 6 "dochia"
        , project model "./gray.jpeg" "6 project" 8 "8"
        , project model "./pink.jpg" "7 project" 9 "9"
        , project model "./blue.jpg" "9 project" 10 "10"
        ]


project : Model -> String -> String -> Int -> String -> Html Msg
project model picturePath description id url =
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vw 30), width (vw 30) ], onMouseOver <| HoverOn id, onMouseOut HoverOff, onClick <| OpenModal id url]
        [ img [ src picturePath, css [ margin zero, height (vw 30), width (vw 30), maxWidth (vw 100), borderRadius (rem 0.2) ] ] []
        , if model.hoveredPicture == id then
            p [ css [ position absolute, backgroundColor Color.transparent, width (vw 30), height (vw 4), bottom (Css.em -1), borderRadius (rem 0.2), color Color.white, fontSize (px 16), display Css.table, letterSpacing (px 2) ] ]
                [ p [ css [ display tableCell, verticalAlign middle ] ] [ text description ]
                ]

          else
            p [] []
        ]


projectModal : Model -> Html Msg
projectModal model = Projects.openModal { closeModal = CloseModal } 
            model.openedModal
            model.mobile




menu : Model -> Html.Styled.Html Msg
menu model =
    div
        [ css
            [ fontSize (px 16)
            , paddingTop (vh 5)
            , letterSpacing (px 4)
            , display tableCell
            , verticalAlign middle
            , textAlign right
            , width <| vw 15
            , if model.menuOn then
                visibility visible

              else
                visibility hidden
            ]
        ]
        [ p
            [ onClick <| JumpTo "projects"
            , css
                [ margin (vw 1)
                , display inlineBlock
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "HOME" ]
        , p
            [ onClick <| JumpTo "projects"
            , css
                [ margin (vw 1)
                , display inlineBlock
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "PROJECTS" ]
        , p
            [ onClick <| OpenModal 7 "about"
            , css
                [ margin (vw 1)
                , display inlineBlock
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "ABOUT" ]
        , p
            [ onClick <| JumpTo "contact"
            , css
                [ margin (vw 1)
                , display inlineBlock
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
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }
