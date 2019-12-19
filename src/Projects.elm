module Projects exposing (aboutText, astroCards, bosch, projectOne, projectTwo, plasmo)

import Color
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)
import Html.Styled.Events exposing (onClick)


type alias Messages message =
    { closeModal : message
    }


modalCss =
    css [ backgroundColor Color.transparent, position fixed, width (vw 100), top zero, height (vh 100), overflow scroll, overflowY auto, overflowX hidden, pointerEvents auto, fontSize (px 0), lineHeight (px 0) ]


projectOne messages =
    div [ modalCss ]
        [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, marginLeft (vw -34) ], onClick messages.closeModal ] []
        , div
            [ css [ width (vw 70), backgroundColor Color.heronBlack, marginLeft (vw 15) ] ]
            [ img [ src "./heron/1.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./heron/2.jpg", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), maxWidth (vw 100), fontSize (px 18), color Color.paleYellow, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
                [ p [ css [] ] [ text "The name of the collection is HERON (a representative element for the Art Deco style and movement), including niche objects, gaining its main inspiration from Art Deco." ]
                , p [ css [] ] [ text "The collection brings back its items from obsolescence, and gives them a design purpose, but a functional one aswell.  The collection consists of 4 objects: a chaise lounge, a bar cart, a set of auxiliary tables and a high stand for plants. The approached shapes recreate the Art Deco style through linear geometry, but breaks the symmetry, characteristic for it, while preserving its well-known elegance. High-quality materials have been used, combining Art Deco with contemporary notes, the collection's pieces getting a modern and stylish feel." ]
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
    div [ modalCss, onClick messages.closeModal ]
        [ div [ css [ width (vw 70), backgroundColor Color.vividRed, marginLeft (vw 15) ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./indagra/indagra1.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./indagra/indagra2.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./indagra/indagra4.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./indagra/indagra5.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , div [ css [ width (vw 46), maxWidth (vw 100), fontSize (px 18), color Color.white, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
                [ p [ css [] ] [ text "New identity for INDAGRA SRL, a company specialized in passive fire protection. For their brand, Indagra wanted an identity that was minimal, professional and bold.   The aim was to create something bespoke as a reflection of the service level that they provide to their clients, being one of the best companies from their field of activity in Romania.  The symbol is a representation of a flame, with flat design style and modern gradients. The symbol is also a rethinked “i” letter, from Indagra." ]
                ]
            , img [ src "./indagra/indagra7.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginBottom zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


astroCards messages =
    div [ modalCss, onClick messages.closeModal ]
        [ div [ css [ width (vw 70), backgroundColor Color.black, marginLeft (vw 15) ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./astro/astro1.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./astro/astro2.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro3.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro4.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro5.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro6.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro7.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro8.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro9.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro10.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./astro/astro11.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginBottom zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


bosch messages =
    div [ modalCss, onClick messages.closeModal ]
        [ div [ css [ width (vw 70), backgroundColor Color.boschBlue, marginLeft (vw 15) ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./bosch/bosch1.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./bosch/bosch2.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), color Color.white, fontSize <| px 16, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "Wall art collaboration project made for BOSCH Romania. I created 3 large mural illustrations for the IT office of BOSCH in Cluj-Napoca.  The main illustration represents a gigantic computer screen in a paralel fantasy universe, where the principal character (computer scientist), hunts down the bug monsters that are eating the code. Each and every detail refers to computer science (for example the sun is a wiFi planet, the trees have mother board branches and the clouds are storage spaces, collecting information from the imaginary IT universe). I wanted to create an atmosphere that captures the dynamism of the company ecosystem with some dedicated illustrations and a vivid color palette, showing that the IT life is not that boring as it seems." ]
            , img [ src "./bosch/bosch4.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./bosch/bosch5.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), color Color.white, fontSize <| px 16, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "The second wall illustration shows the importance of professionals and teamwork, which is the base of the company’s core values. Together, they build a world of IOT, where everything is connected. The details refer to the IT world also here (the stars are numbers of the binary ?)" ]
            , img [ src "./bosch/bosch7.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , div [ css [ width (vw 46), color Color.white, fontSize <| px 16, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "The third illustration is a reinterpretation of Michelangelo’s  famous fresco painting, The Creation of Adam. It illustrates the creation of the machines, and the human is shown as God., the creator." ]
            , img [ src "./bosch/bosch9.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./bosch/bosch10.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./bosch/bosch11.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./bosch/bosch12.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./bosch/bosch13.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginBottom zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]


plasmo messages =
    div [ modalCss, onClick messages.closeModal ]
        [ div [ css [ width (vw 70), backgroundColor Color.black, marginLeft (vw 15) ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./plasmo/plasmo1.png", css [ width (vw 70), maxWidth (vw 100), margin zero ] ] []
            , img [ src "./plasmo/plasmo2.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo3.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo4.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , p [ css [ width (vw 46), color Color.white, fontSize <| px 16, marginLeft (vw 12), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "Plasmo Life is a company that is specialized in Plasma Lifting, which is a non-invasive aesthetic answer to surgical lifting procedures, it activates skin cells by application of own plasma. Plasma biomaterial contains unique combination of highly effective substances – growth factors, thrombocytes, leukocyte and stem cells. They activate new cell production and regenerate damaged cells." ]
            , p [ css [ width (vw 46), color Color.white, fontSize <| px 16, marginLeft (vw 12), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "The goal was to create a visual identity system that is inspired by the blood cells and plasma, yet is not scary and inspires trust and professionalism." ]
            , img [ src "./plasmo/plasmo6.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo7.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo8.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo9.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo10.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
            , img [ src "./plasmo/plasmo11.png", css [ width (vw 70), maxWidth (vw 100), margin zero, marginBottom zero ] ] []
            ]
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.paleYellow ] ] [ text "© 2019 Beata Csaka. All Rights Reserved" ]
        ]

aboutText : Html msg
aboutText =
    text "Hello. My name is Beata Csaka.  I am a multi-disciplinary designer, specialized in product, graphic and interior design.  I studied design at the University of Art and Design of Cluj-Napoca and Accademia di Belli Arti di Bari, Italy, obtaining my BA and MA degrees. I am always seeking for beauty and searching to find equilibrium in everything I do, whenever it is about materials, color palettes or proportions. My work distinguishes itself with the combination of mostly natural, bold, high quality materials and color schemes, while my love for minimalism is peppered with the combination of all kind of styles, depending on the project. Through the vast number of collaborations from various fields and diverse range of clients, I explore function, through the perspective of aesthetics.  I believes design is more than producing something, it is a journey, that requires some qualities along the way, that I consider I do have. First, curiosity, to question everything, to understand why things are the way they are. Then, courage to change them. Creativity to explore new concepts, forms and ideas. Discipline, to drive continual refinement. And the most important, passion, to be dedicated and enjoy the whole journey and deliver successful narratives through the visualization of my design work.  This online portfolio is a visual journey trough some of my projects! Enjoy it!"
