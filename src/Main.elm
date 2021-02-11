module Main exposing (..)

import Browser
import Browser.Dom as Dom
import Browser.Events
import Browser.Navigation as Nav
import Color
import Css exposing (..)
import Ease
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, id, src, style, target)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Projects
import SmoothScroll exposing (Config, scrollToWithOptions)
import Task
import Time as Time
import Url
import Url.Parser as Url exposing ((</>), Parser)



---- MODEL ----


defaultConfig : Config
defaultConfig =
    { offset = 12
    , speed = 30
    , easing = Ease.outQuint
    }


fastConfig : Config
fastConfig =
    { offset = 0
    , speed = 200
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
    | OpenModal Int
    | OpenAbout
    | HoverOn Int
    | HoverOff
    | DoNothing
    | JumpTo String
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
              -- , Nav.pushUrl model.key "/home"
            , Task.attempt (always DoNothing) (scrollToWithOptions fastConfig (String.fromInt model.openedModal))
            )

        OpenModal projectId ->
            ( { model | openedModal = projectId, bodyCss = [ cursor crosshair, height <| vh 100, overflow hidden, overflowY hidden, pointerEvents none ], modalOn = True, toTopButtonShow = False }
            , Cmd.none
            )

        OpenAbout ->
            ( { model | openedModal = 7, menuOn = False, bodyCss = [ cursor crosshair, height <| vh 100, overflow hidden, overflowY hidden, pointerEvents none ], modalOn = True, toTopButtonShow = False }
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
            , Nav.pushUrl model.key "/"
            )

        JumpTo id ->
            ( { model | menuOn = False }
            , Task.attempt (always DoNothing) (scrollToWithOptions defaultConfig id)
            )

        WindowResize w h ->
            ( { model | height = h, width = w, mobile = w < 700 }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )
                    -- ( model, Cmd.none )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                mod =
                    if url.path == "/" then
                        { model | openedModal = 0, bodyCss = [ cursor crosshair, overflowY hidden ], modalOn = False }

                    else
                        model
            in
            ( mod
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
    Sub.batch
        [ Browser.Events.onResize WindowResize
        , if model.modalOn then
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
                [ home model
                , projectTable model
                , projectModal model
                , toTopButton model
                , footer model
                ]
    in
    { body = [ Html.Styled.toUnstyled body ]
    , title = "Beata Csaka"
    }


home : Model -> Html Msg
home model =
    if model.mobile then
        homeMobile model

    else
        homeDesktop model


homeDesktop : Model -> Html Msg
homeDesktop model =
    div [ id "home", css [ displayFlex, alignItems center, justifyContent center, flexDirection row, verticalAlign center ] ]
        [ menuButton model
        , menu model
        , a [ href "about" ] [ img [ src "./buttons/logo.svg", css [ marginLeft <| vw 5, marginTop <| vh 15, marginRight <| vw 25, marginBottom <| vh 15, height (vw 28), width (vw 28), maxWidth (vw 100) ], onClick <| OpenModal 7 ] [] ]
        , img [ src "./buttons/down.svg", css [ height (vmin 3), width (vmin 3) ], onClick <| JumpTo "projects" ] []
        ]


homeMobile : Model -> Html Msg
homeMobile model =
    div [ id "home", css [ displayFlex, alignItems center, justifyContent center, flexDirection row, verticalAlign center ] ]
        [ div [ css [ Css.property "writing-mode" "vertical-rl", transform (rotate (deg 180)), margin zero, height (vw 34), width (vw 28), displayFlex, alignItems center, justifyContent center, letterSpacing (px 5), fontSize (px 8) ] ] [ text "BEÁTA CSÁKA" ]
        , a [ href "about" ] [ img [ src "./buttons/logo.svg", css [ marginLeft <| vw 5, marginTop <| vh 10, marginRight <| vw 5, marginBottom <| vh 10, height (vw 34), width (vw 34), maxWidth (vw 100) ], onClick <| OpenModal 7 ] [] ]
        , menuButtonMobile model
        , if model.menuOn then
            menuMobile model

          else
            div [] []
        ]


menuButton : Model -> Html Msg
menuButton model =
    div [ css [ height (vw 28), width (vw 3), margin zero, displayFlex, flexDirection column ] ]
        [ div [ css [ Css.property "writing-mode" "vertical-rl", transform (rotate (deg 180)), margin zero, width (vw 3), height (vw 12), displayFlex, alignItems center, justifyContent flexEnd, letterSpacing (px 5), fontSize (px 12) ] ] [ text "BEÁTA CSÁKA" ]
        , div [ onClick TogleMenu, css [ width (vw 3), paddingTop <| vw 1 ] ]
            [ if model.menuOn then
                img [ src "./buttons/x_black.svg", css [ height (vmin 3), width (vmin 3), margin zero ] ] []

              else
                img [ src "./buttons/menu.svg", css [ height (vmin 3), width (vmin 3), margin zero ] ] []
            ]
        ]


menuButtonMobile model =
    div [ css [ height (vw 34), width (vw 28), displayFlex, alignItems center, justifyContent center ] ]
        [ if model.menuOn then
            img [ src "./buttons/x_black.svg", css [ height (px 16), width (px 16), margin zero, padding <| vw 5 ], onClick TogleMenu ] []

          else
            img [ src "./buttons/menu.svg", css [ height (px 16), width (px 16), margin zero, padding <| vw 5 ], onClick TogleMenu ] []
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
            , width <| vw 18
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
        , a [ href "about", css [ color Color.black, textDecorationLine none ] ]
            [ p
                [ onClick <| OpenModal 7
                , css
                    [ displayFlex
                    , justifyContent flexEnd
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "ABOUT/" ]
            ]
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


menuCss =
    css [ backgroundColor Color.white, position fixed, width (vw 100), top zero, height (vh 100), overflow scroll, zIndex (int 2) ]


menuMobile : Model -> Html.Styled.Html Msg
menuMobile model =
    div
        [ menuCss
        ]
        [ menuButtonMobile model
        , div [ css [ displayFlex, alignItems center, justifyContent center, flexDirection column, verticalAlign center ] ]
            [ p
                [ onClick <| JumpTo "projects"
                , css
                    [ displayFlex
                    , paddingTop <| vh 20
                    , justifyContent center
                    ]
                ]
                [ text "PROJECTS/" ]
            , a [ href "about", css [ color Color.black, textDecorationLine none ] ]
                [ p
                    [ onClick <| OpenAbout
                    , css
                        [ displayFlex
                        , justifyContent center
                        ]
                    ]
                    [ text "ABOUT/" ]
                ]
            , p
                [ onClick <| JumpTo "contact"
                , css
                    [ displayFlex
                    , justifyContent center
                    ]
                ]
                [ text "CONTACT/" ]
            ]
        ]


projectTable : Model -> Html Msg
projectTable model =
    div [ css [ maxWidth (vw 100), fontSize (px 0) ], id "projects" ]
        [ project model "./csb/heronlogo_main.jpg" "HERON LOGO" 12 "hlogo"
        , project model "./heron/heron_main.jpg" "HERON COLLECTION" 1 "heron"
        , project model "./astro/astro_main.png" "ASTRO CARDS" 3 "astro"
        , project model "./vino/in_vino_veritas.jpg" "IN VINO VERITAS" 11 "vino"
        , project model "./dochia/dochia_main.png" "CASA LU' DOCHIA" 6 "dochia"
        , project model "./indagra/indagra_landing.png" "INDAGRA" 2 "indagra"
        , project model "./plasmo/plasmo_main.png" "PLASMO LIFE" 5 "plasmo"
        , project model "./crown/crown_main.png" "ICE AND WIRE CROWN" 8 "crown"
        , project model "./exlibris/exlibris_main.png" "EX LIBRIS" 10 "exlibris"
        , project model "./bosch/bosch_main.png" "BOSCH WALL ART" 4 "bosch"
        , project model "./ec/ec_main.png" "EC 7" 9 "7sins"
        , project model "./kups/kups5.jpg" "Kups" 13 "kups"
        ]


project : Model -> String -> String -> Int -> String -> Html Msg
project model picturePath description projectId url =
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vw 30), width (vw 30) ], onMouseOver <| HoverOn projectId, onMouseOut HoverOff, onClick <| OpenModal projectId, id (String.fromInt projectId) ]
        [ a [ href url ]
            [ img [ src picturePath, css [ margin zero, height (vw 30), width (vw 30), maxWidth (vw 100), borderRadius (rem 0.2) ] ] []
            , if model.hoveredPicture == projectId then
                p [ css [ position absolute, backgroundColor Color.transparent, width (vw 30), height (vw 4), bottom (Css.em -1), borderRadius (rem 0.2), color Color.white, fontSize (px 16), display Css.table, letterSpacing (px 2) ] ]
                    [ p [ css [ display tableCell, verticalAlign middle ] ] [ text description ]
                    ]

              else
                p [] []
            ]
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
            , bottom <| vh 31
            , right <| vw 1.5
            , if model.toTopButtonShow then
                visibility visible

              else
                visibility hidden
            ]
        , onClick <| JumpTo "home"
        ]
        []


contact : Model -> Html Msg
contact model =
    let
        sizes =
            if model.mobile then
                { logoSize = px 14
                , buttonWidth = vw 15
                }

            else
                { logoSize = px 20
                , buttonWidth = vw 8
                }
    in
    div [ id "contact", css [ displayFlex, alignItems center, justifyContent center, flexDirection row, height (vh 10) ] ]
        [ a [ css [ width sizes.buttonWidth ], href "mailto:beaa.csaka@gmail.com", target "_blank" ] [ img [ src "./icons/mail_white.svg", css [ height sizes.logoSize ] ] [] ]
        , a [ css [ width sizes.buttonWidth ], href "https://www.instagram.com/beaaacska", target "_blank" ] [ img [ src "./icons/instagram_white.svg", css [ height sizes.logoSize ] ] [] ]
        , a [ css [ width sizes.buttonWidth ], href "https://www.behance.net/beatacsaka", target "_blank" ] [ img [ src "./icons/behance_white.svg", css [ height sizes.logoSize ] ] [] ]
        , a [ css [ width sizes.buttonWidth ], href "https://www.pinterest.com/beaacsaka", target "_blank" ] [ img [ src "./icons/pinterest_white.svg", css [ height sizes.logoSize ] ] [] ]
        , a [ css [ width sizes.buttonWidth ], href "https://www.linkedin.com/in/csakabeata/", target "_blank" ] [ img [ src "./icons/linkedin_white.svg", css [ height sizes.logoSize ] ] [] ]
        ]


footer : Model -> Html Msg
footer model =
    nav [ css [ padding (vh 3.5), marginTop <| vh 5, fontSize (px 12), backgroundColor Color.black, color Color.white, height (vmin 25), displayFlex, alignItems center, justifyContent center, flexDirection column ] ]
        [ contact model
        , div [ css [ paddingTop <| vh 2 ] ] [ text "© 2021 Beáta Csáka. All Rights Reserved" ]
        , img [ src "./bea_logo_white.png", css [ margin (px 20), height (vmin 6), width (vmin 6) ] ] []
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
