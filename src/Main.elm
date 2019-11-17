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
    rgba 0 0 0 0.2


brown : Color
brown =
    rgb 153 102 0


white : Color
white =
    rgb 255 255 255


type Page
    = Home
    | Contact


type alias Model =
    { menuOn : Bool
    , modalOn : Bool
    , hoverOn : Bool
    , hoveredPicture : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { menuOn = False
      , modalOn = False
      , hoverOn = False
      , hoveredPicture = 0
      }
    , Cmd.none
    )


type Msg
    = TogleMenu
    | CloseModal
    | OpenModal
    | HoverOn Int
    | HoverOff


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TogleMenu ->
            ( { model | menuOn = not model.menuOn }
            , Cmd.none
            )

        CloseModal ->
            ( { model | modalOn = False }
            , Cmd.none
            )

        OpenModal ->
            ( { model | modalOn = True }
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


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
        [ project model "./pink.jpg" "first project" 1
        , project model "./blue.jpg" "2 project" 2
        , project model "./gray.jpeg" "3 project" 3
        , project model "./pink.jpg" "4 project" 4
        , project model "./blue.jpg" "5 project" 5
        , project model "./gray.jpeg" "6 project" 6
        , project model "./pink.jpg" "7 project" 7
        ]


project : Model -> String -> String -> Int -> Html Msg
project model picturePath description id =
    div [ css [ display inlineBlock, position relative, margin (px 2), height (vmax 30), width (vmax 30) ], onMouseOver <| HoverOn id, onMouseOut HoverOff ]
        [ img [ src picturePath, onClick OpenModal, css [ margin zero, height (vmax 30), width (vmax 30), maxWidth (vw 100), borderRadius (rem 0.2) ] ] []
        , if model.hoveredPicture == id then
            p [ css [ position absolute, backgroundColor transparent, width (vmax 30), height (vmax 4.5), bottom (px -16), borderRadius (rem 0.2) ] ] [ text description ]

          else
            p [] []
        ]


projectModal : Model -> Html Msg
projectModal model =
    if model.modalOn then
        div [ css [ backgroundColor white, position fixed, left (vw 10), width (vw 80), top (vh 10), overflow auto, borderRadius (rem 0.2) ] ]
            [ div []
                [ h1 [ css [ display Css.table, margin (px 100) ] ]
                    [ span [ css [ display tableCell, verticalAlign middle ] ] [ text "Header" ]
                    , img [ src "./cross.png", css [ display tableCell, verticalAlign middle, left (px 100), height (px 16), width (px 16) ], onClick CloseModal ] []
                    ]
                ]
            , div [ css [ margin (px 100), textAlign left ] ]
                [ text
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \n                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, \n                    but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem \n                    Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\n                    \n                    It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it \n                    has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and \n                    web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. \n                    Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \n                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, \n                    but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem \n                    Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\n                    \n                    It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it \n                    has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and \n                    web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. \n                    Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \n                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, \n                    but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem \n                    Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\n                    \n                    It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it \n                    has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and \n                    web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. \n                    VarioLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \n                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, \n                    but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem \n                    Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\n                    \n                    It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it \n                    has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and \n                    web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. \n                    Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).us versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
                ]
            , div [ css [ paddingTop (vh 2) ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
            ]

    else
        div [] []


about : Html Msg
about =
    div [ css [ margin (vmin 10), lineHeight (px 30) ] ] [ text "Hello. My name is Beata Csaka. \nI am a multi-disciplinary designer, specialized in product, graphic and interior design. \nI studied design at the University of Art and Design of Cluj-Napoca and Accademia di Belli Arti di Bari, Italy, obtaining my BA and MA degrees.\nI am always seeking for beauty and searching to find equilibrium in everything I do, whenever it is about materials, color palettes or proportions. My work distinguishes itself with the combination of mostly natural, bold, high quality materials and color schemes, while my love for minimalism is peppered with the combination of all kind of styles, depending on the project. Through the vast number of collaborations from various fields and diverse range of clients, I explore function, through the perspective of aesthetics. \nI believes design is more than producing something, it is a journey, that requires some qualities along the way, that I consider I do have. First, curiosity, to question everything, to understand why things are the way they are. Then, courage to change them. Creativity to explore new concepts, forms and ideas. Discipline, to drive continual refinement. And the most important, passion, to be dedicated and enjoy the whole journey and deliver successful narratives through the visualization of my design work. \nThis online portfolio is a visual journey trough some of my projects! Enjoy it!" ]


menu : Model -> Html.Styled.Html Msg
menu model =
    if model.menuOn then
        div
            [ css [ fontSize (px 24) ]
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
