module Main exposing (..)

-- import Action

import Browser exposing (UrlRequest(..))
import Browser.Dom as Dom
import Color
import Css exposing (..)
import Ease
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Projects
import SmoothScroll exposing (Config, scrollTo, scrollToWithOptions)
import Task



---- MODEL ----


defaultConfig : Config
defaultConfig =
    { offset = 12
    , speed = 50
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


jumpTo : String -> Cmd Msg
jumpTo id =
    Dom.getElement id
        |> Task.andThen (\info -> Dom.setViewport 0 info.element.y)
        |> Task.attempt (\_ -> DoNothing)


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
            ( { model | openedModal = id, bodyCss = [ cursor crosshair, overflow hidden, overflowY hidden ] }
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
        , style "scroll-behavior" "smooth"
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
        [ menuHoverButton model
        , img [ src "./bea_logo.png", css [ margin (vmin 15), height (vmin 60), width (vmin 60), maxWidth (vw 100) ] ] []
        , img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), marginLeft (vmin 25), visibility hidden ] ] []
        ]


menuHoverButton : Model -> Html.Styled.Html Msg
menuHoverButton model =
    if model.menuOn then
        img [ src "./cross.png", css [ height (vmin 4), width (vmin 4), marginRight (vmin 25) ], onClick TogleMenu ] []

    else
        img [ src "./hamburger.png", css [ height (vmin 4), width (vmin 4), marginRight (vmin 25) ], onClick TogleMenu ] []


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
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vmax 30), width (vmax 30) ], onMouseOver <| HoverOn id, onMouseOut HoverOff, onClick (OpenModal id) ]
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
    div [ css [ margin (vw 12), width (vw 76), lineHeight (Css.em 2), fontSize (px 18) ], id "about" ] [ text "Hello. My name is Beata Csaka. \nI am a multi-disciplinary designer, specialized in product, graphic and interior design. \nI studied design at the University of Art and Design of Cluj-Napoca and Accademia di Belli Arti di Bari, Italy, obtaining my BA and MA degrees.\nI am always seeking for beauty and searching to find equilibrium in everything I do, whenever it is about materials, color palettes or proportions. My work distinguishes itself with the combination of mostly natural, bold, high quality materials and color schemes, while my love for minimalism is peppered with the combination of all kind of styles, depending on the project. Through the vast number of collaborations from various fields and diverse range of clients, I explore function, through the perspective of aesthetics. \nI believes design is more than producing something, it is a journey, that requires some qualities along the way, that I consider I do have. First, curiosity, to question everything, to understand why things are the way they are. Then, courage to change them. Creativity to explore new concepts, forms and ideas. Discipline, to drive continual refinement. And the most important, passion, to be dedicated and enjoy the whole journey and deliver successful narratives through the visualization of my design work. \nThis online portfolio is a visual journey trough some of my projects! Enjoy it!" ]


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
