module Main exposing (..)

import Browser
import Browser.Dom as Dom
import Browser.Events
import Browser.Navigation as Nav
import Color
import Css exposing (..)
import Ease
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Projects
import SmoothScroll exposing (Config, scrollToWithOptions)
import Svg.Styled.Attributes as SvgAttributes
import Task
import Time as Time
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
    , modalOn : Bool
    , bodyCss : List Style
    , width : Int
    , height : Int
    , mobile : Bool
    , toTopButtonShow : Bool
    , key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { menuOn = False
      , hoverOn = False
      , hoveredPicture = 0
      , openedModal = 0
      , modalOn = False
      , bodyCss = [ cursor crosshair, overflow hidden, overflowY hidden ]
      , width = 0
      , height = 0
      , mobile = False
      , toTopButtonShow = False
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
    | ShowToTopButton Dom.Viewport
    | GetViewportClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TogleMenu ->
            ( { model | menuOn = not model.menuOn }
            , Cmd.none
            )

        CloseModal ->
            ( { model | openedModal = 0, bodyCss = [ cursor crosshair, overflowY hidden ], modalOn = False }
            , Nav.pushUrl model.key "/home"
            )

        OpenModal id url ->
            ( { model | openedModal = id, bodyCss = [ cursor crosshair, height <| vh 100, overflow hidden, overflowY hidden, pointerEvents none ], modalOn = True, toTopButtonShow = False }
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

        WindowResize w h ->
            ( { model | height = h, width = w, mobile = w < 600 }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Cmd.none )

                Browser.External href ->
                    ( model, Cmd.none )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        GetViewportClicked ->
            ( model, Task.perform ShowToTopButton Dom.getViewport )

        ShowToTopButton vp ->
            if floor vp.viewport.y >= model.height then
                ( { model | toTopButtonShow = True }
                , Cmd.none
                )

            else
                ( { model | toTopButtonShow = False }
                , Cmd.none
                )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Browser.Events.onResize WindowResize, 
        if model.modalOn then 
            Sub.none
        else
            Time.every 200 (always GetViewportClicked) 
            ]



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
                , toTopButton model
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
    div [ id "home", css [ displayFlex, alignItems center, justifyContent center, flexDirection row, verticalAlign center ] ]
        [ menuButton model
        , menu model
        , img [ src "./buttons/logo.svg", css [ marginLeft <| vw 5, marginTop <| vh 15, marginRight <| vw 22, marginBottom <| vh 15, height (vw 28), width (vw 28), maxWidth (vw 100) ], onClick <| OpenModal 7 "about" ] []
        , img [ src "./buttons/down.svg", css [ height (vmin 3), width (vmin 3) ], onClick <| JumpTo "projects" ] []
        ]


menuButton : Model -> Html Msg
menuButton model =
    div [ css [ height (vw 28), width (vw 3), margin zero, displayFlex, flexDirection column ] ]
        [ div [ css [ Css.property "writing-mode" "vertical-rl", transform (rotate (deg 180)), margin zero, width (vw 3), height (vw 12), displayFlex, alignItems center, justifyContent flexEnd, letterSpacing (px 5), fontSize (px 12) ] ] [ text "BEATA CSAKA" ]
        , div [ onClick TogleMenu, css [ width (vw 3), paddingTop <| vw 1 ] ]
            [ if model.menuOn then
                img [ src "./buttons/x_black.svg", css [ height (vmin 3), width (vmin 3), margin zero ] ] []

              else
                img [ src "./buttons/menu.svg", css [ height (vmin 3), width (vmin 3), margin zero ] ] []
            ]
        ]


menu : Model -> Html.Styled.Html Msg
menu model =
    div
        [ css
            [ fontSize (px 12)
            , letterSpacing (px 5)
            , displayFlex
            , flexDirection column
            , justifyContent center
            , width <| vw 15
            , height <| vw 30
            , if model.menuOn then
                visibility visible

              else
                visibility hidden
            ]
        ]
        [ p
            [ onClick <| JumpTo "projects"
            , css
                [ displayFlex
                , justifyContent flexEnd
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "PROJECTS/" ]
        , p
            [ onClick <| OpenModal 7 "about"
            , css
                [ displayFlex
                , justifyContent flexEnd
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "ABOUT/" ]
        , p
            [ onClick <| JumpTo "contact"
            , css
                [ displayFlex
                , justifyContent flexEnd
                , hover
                    [ textDecorationLine underline
                    ]
                ]
            ]
            [ text "CONTACT/" ]
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
        , project model "./crown/crown_main.png" "ICE AND WIRE CROWN" 8 "crown"
        , project model "./ec/ec_main.png" "EC 7" 9 "7sins"
        , project model "./exlibris/exlibris_main.png" "EX LIBRIS" 10 "exlibris"
        ]


project : Model -> String -> String -> Int -> String -> Html Msg
project model picturePath description id url =
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vw 30), width (vw 30) ], onMouseOver <| HoverOn id, onMouseOut HoverOff, onClick <| OpenModal id url ]
        [ img [ src picturePath, css [ margin zero, height (vw 30), width (vw 30), maxWidth (vw 100), borderRadius (rem 0.2) ] ] []
        , if model.hoveredPicture == id then
            p [ css [ position absolute, backgroundColor Color.transparent, width (vw 30), height (vw 4), bottom (Css.em -1), borderRadius (rem 0.2), color Color.white, fontSize (px 16), display Css.table, letterSpacing (px 2) ] ]
                [ p [ css [ display tableCell, verticalAlign middle ] ] [ text description ]
                ]

          else
            p [] []
        ]


projectModal : Model -> Html Msg
projectModal model =
    Projects.openModal { closeModal = CloseModal }
        model.openedModal
        model.mobile


toTopButton : Model -> Html Msg
toTopButton model =
    img
        [ src "./buttons/up.svg"
        , css
            [ height (vmin 3)
            , width (vmin 3)
            , position fixed
            , bottom <| vmin 17
            , right <| vw 1.5
            , if model.toTopButtonShow then
                visibility visible

              else
                visibility hidden
            ]
        , onClick <| JumpTo "home"
        ]
        []


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
