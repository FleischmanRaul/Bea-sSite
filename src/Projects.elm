module Projects exposing (aboutText, projectOne, projectTwo)

import Browser exposing (UrlRequest(..))
import Browser.Dom as Dom
import Color
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id, src, style)
import Html.Styled.Events exposing (onClick, onMouseOut, onMouseOver)
import Task


type alias Messages message =
    { closeModal : message
    }


modalCss =
    css [ backgroundColor Color.transparent, position fixed, width (vw 100), top zero, height (vh 100), overflow scroll, overflowY auto, overflowX hidden, pointerEvents auto ]


projectOne messages =
    div [ modalCss, onClick messages.closeModal ]
        [ div [ css [ width (vw 70), backgroundColor Color.heronBlack, marginLeft (vw 15), fontSize (px 0) ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./heron/1.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero, pointerEvents none ] ] []
            , img [ src "./heron/2.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), maxWidth (vw 100), fontSize (px 18), color Color.paleYellow, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
                [ p [ css [] ] [ text "The name of the collection is HERON (a representative element for the Art Deco style and movement), including niche objects, gaining its main inspiration from Art Deco." ]
                , p [ css [] ] [ text "The collection brings back its items from obsolescence, and gives them a design purpose, but a functional one aswell. \nThe collection consists of 4 objects: a chaise lounge, a bar cart, a set of auxiliary tables and a high stand for plants. The approached shapes recreate the Art Deco style through linear geometry, but breaks the symmetry, characteristic for it, while preserving its well-known elegance. High-quality materials have been used, combining Art Deco with contemporary notes, the collection's pieces getting a modern and stylish feel." ]
                ]
            , img [ src "./heron/4.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./heron/5.png", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15) ] ] []
            , img [ src "./heron/6.png", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15) ] ] []
            , img [ src "./heron/7.jpg", css [ width (vw 70), maxWidth (vw 100), marginTop (vh 15), marginBottom zero ] ] []
            , img [ src "./heron/8.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


projectTwo messages =
    div [ modalCss ]
        [ div []
            [ h1 [ css [ display Css.table, margin (px 100) ] ]
                [ span [ css [ display tableCell, verticalAlign middle ] ] [ text "Header" ]
                , img [ src "./cross.png", css [ display tableCell, verticalAlign middle, left (px 100), height (px 16), width (px 16) ], onClick messages.closeModal ] []
                ]
            ]
        , div [ css [ margin (px 100), textAlign left ] ]
            [ text
                "Second one"
            ]
        , div [ css [ paddingTop (vh 2) ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


aboutText =
    text "Hello. My name is Beata Csaka. \nI am a multi-disciplinary designer, specialized in product, graphic and interior design. \nI studied design at the University of Art and Design of Cluj-Napoca and Accademia di Belli Arti di Bari, Italy, obtaining my BA and MA degrees.\nI am always seeking for beauty and searching to find equilibrium in everything I do, whenever it is about materials, color palettes or proportions. My work distinguishes itself with the combination of mostly natural, bold, high quality materials and color schemes, while my love for minimalism is peppered with the combination of all kind of styles, depending on the project. Through the vast number of collaborations from various fields and diverse range of clients, I explore function, through the perspective of aesthetics. \nI believes design is more than producing something, it is a journey, that requires some qualities along the way, that I consider I do have. First, curiosity, to question everything, to understand why things are the way they are. Then, courage to change them. Creativity to explore new concepts, forms and ideas. Discipline, to drive continual refinement. And the most important, passion, to be dedicated and enjoy the whole journey and deliver successful narratives through the visualization of my design work. \nThis online portfolio is a visual journey trough some of my projects! Enjoy it!"
