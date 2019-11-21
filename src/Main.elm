module Main exposing (..)

-- import Action

import Browser exposing (UrlRequest(..))
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)



---- MODEL ----


black : Color
black =
    rgb 0 0 0


transparent : Color
transparent =
    rgba 30 30 30 0.8


hoverColor : Color
hoverColor =
    rgba 30 30 30 0.2


modalColor : Color
modalColor =
    rgb 230 230 234


brown : Color
brown =
    rgb 153 102 0


white : Color
white =
    rgb 255 255 255


heronBlack : Color
heronBlack =
    rgb 35 30 37


paleYellow : Color
paleYellow =
    rgb 255 251 214


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
    div [ css [ maxWidth (vw 100) ] ]
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
            p [ css [ position absolute, backgroundColor transparent, width (vmax 30), height (vmax 4), bottom (Css.em -1), borderRadius (rem 0.2), color white, fontSize (px 20), display Css.table ] ]
                [ p [ css [ display tableCell, verticalAlign middle, fontWeight bold ] ] [ text description ]
                ]

          else
            p [] []
        ]


projectModal : Model -> Html Msg
projectModal model =
    if model.openedModal == 1 then
        projectOne model

    else if model.openedModal == 2 then
        projectTwo model

    else
        div [] []


projectOne model =
    div [ css [ backgroundColor transparent, position fixed, width (vw 100), top zero, height (vh 100), overflow scroll, overflowY auto, overflowX hidden ], onClick CloseModal ]
        [ div [ css [ width (vw 70), backgroundColor heronBlack, marginLeft (vw 15), fontSize (px 0), pointerEvents none ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick CloseModal ] []
            , img [ src "./heron/1.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./heron/2.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), maxWidth (vw 100), fontSize (px 18), color paleYellow, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
                [ p [ css [] ] [ text "The name of the collection is HERON (a representative element for the Art Deco style and movement), including niche objects, gaining its main inspiration from Art Deco." ]
                , p [ css [] ] [ text "The collection brings back its items from obsolescence, and gives them a design purpose, but a functional one aswell. \nThe collection consists of 4 objects: a chaise lounge, a bar cart, a set of auxiliary tables and a high stand for plants. The approached shapes recreate the Art Deco style through linear geometry, but breaks the symmetry, characteristic for it, while preserving its well-known elegance. High-quality materials have been used, combining Art Deco with contemporary notes, the collection's pieces getting a modern and stylish feel." ]
                ]
            , img [ src "./heron/4.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./heron/5.png", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15) ] ] []
            , img [ src "./heron/6.png", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15) ] ] []
            , img [ src "./heron/7.jpg", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15), marginBottom zero ] ] []
            , img [ src "./heron/8.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


projectTwo model =
    div [ css [ backgroundColor white, position fixed, left (vw 10), width (vw 80), top (vh 10), overflow auto, borderRadius (rem 0.2) ] ]
        [ div []
            [ h1 [ css [ display Css.table, margin (px 100) ] ]
                [ span [ css [ display tableCell, verticalAlign middle ] ] [ text "Header" ]
                , img [ src "./cross.png", css [ display tableCell, verticalAlign middle, left (px 100), height (px 16), width (px 16) ], onClick CloseModal ] []
                ]
            ]
        , div [ css [ margin (px 100), textAlign left ] ]
            [ text
                "Second one"
            ]
        , div [ css [ paddingTop (vh 2) ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


about : Html Msg
about =
    div [ css [ margin (vw 12), width (vw 76), lineHeight (Css.em 2), fontSize (px 18) ] ] [ text "Hello. My name is Beata Csaka. \nI am a multi-disciplinary designer, specialized in product, graphic and interior design. \nI studied design at the University of Art and Design of Cluj-Napoca and Accademia di Belli Arti di Bari, Italy, obtaining my BA and MA degrees.\nI am always seeking for beauty and searching to find equilibrium in everything I do, whenever it is about materials, color palettes or proportions. My work distinguishes itself with the combination of mostly natural, bold, high quality materials and color schemes, while my love for minimalism is peppered with the combination of all kind of styles, depending on the project. Through the vast number of collaborations from various fields and diverse range of clients, I explore function, through the perspective of aesthetics. \nI believes design is more than producing something, it is a journey, that requires some qualities along the way, that I consider I do have. First, curiosity, to question everything, to understand why things are the way they are. Then, courage to change them. Creativity to explore new concepts, forms and ideas. Discipline, to drive continual refinement. And the most important, passion, to be dedicated and enjoy the whole journey and deliver successful narratives through the visualization of my design work. \nThis online portfolio is a visual journey trough some of my projects! Enjoy it!" ]


menu : Model -> Html.Styled.Html Msg
menu model =
    if model.menuOn then
        div
            [ css [ fontSize (px 24), paddingTop (px 20) ]
            ]
            [ a
                [ onClick TogleMenu
                , css
                    [ margin (px 30)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Home" ]
            , a
                [ onClick TogleMenu
                , css
                    [ margin (px 30)
                    , hover
                        [ textDecorationLine underline
                        ]
                    ]
                ]
                [ text "Projects" ]
            , a
                [ onClick TogleMenu
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
