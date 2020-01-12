module Projects exposing (about, astroCards, bosch, dochia, heron, indagra, openModal, plasmo)

import Color
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)
import Html.Styled.Events exposing (onClick)


type alias Messages message =
    { closeModal : message
    }


type alias Sizes =
    { width : Css.Vw
    , fontSize : Css.Px
    , leftMargin : Css.Vw
    , textWidth : Css.Vw
    }


modalCss =
    css [ backgroundColor Color.transparent, position fixed, width (vw 100), top zero, height (vh 100), overflow scroll, overflowY auto, overflowX hidden, pointerEvents auto, fontSize (px 0), lineHeight (px 0) ]


openModal messages id onMobile =
    let
        sizes =
            if onMobile then
                { width = vw 100
                , fontSize = px 12
                , leftMargin = vw 0
                , textWidth = vw 88
                }

            else
                { width = vw 90
                , fontSize = px 16
                , leftMargin = vw 5
                , textWidth = vw 78
                }
    in
    if id == 1 then
        modalFrame messages <| heron sizes

    else if id == 2 then
        modalFrame messages <| indagra sizes

    else if id == 3 then
        modalFrame messages <| astroCards sizes

    else if id == 4 then
        modalFrame messages <| bosch sizes

    else if id == 5 then
        modalFrame messages <| plasmo sizes

    else if id == 6 then
        modalFrame messages <| dochia sizes

    else if id == 7 then
        about messages sizes

    else if id == 8 then
        modalFrame messages <| crown sizes

    else if id == 9 then
        modalFrame messages <| ec sizes

    else if id == 10 then
        modalFrame messages <| exlibris sizes

    else
        div [] []


modalFrame messages project =
    div [ modalCss ]
        [ div [css [width <| vw 5, position fixed, height <| vh 100], onClick messages.closeModal] [img [ src "./buttons/x_white.svg", css [ height (px 16), width (px 16), position fixed, marginLeft (vw -0.5) ], onClick messages.closeModal ] []]
        , project
        , div [ css [ paddingTop (vh 2), display inlineBlock, color Color.white, fontSize (px 12) ] ] [ text "© 2020 Beata Csaka. All Rights Reserved" ]
        ]


heron sizes =
    div [ css [ width sizes.width, backgroundColor Color.heronBlack, marginLeft sizes.leftMargin ] ]
        [ img [ src "./heron/1.jpg", css [ width sizes.width, maxWidth (vw 100), margin zero, pointerEvents none ] ] []
        , img [ src "./heron/2.jpg", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , div [ css [ width sizes.textWidth, maxWidth (vw 100), fontSize sizes.fontSize, color Color.paleYellow, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
            [ p [ css [] ] [ text "The name of the collection is HERON (a representative element for the Art Deco style and movement), including niche objects, gaining its main inspiration from Art Deco." ]
            , p [ css [] ] [ text "The collection brings back its items from obsolescence, and gives them a design purpose, but a functional one aswell.  The collection consists of 4 objects: a chaise lounge, a bar cart, a set of auxiliary tables and a high stand for plants. The approached shapes recreate the Art Deco style through linear geometry, but breaks the symmetry, characteristic for it, while preserving its well-known elegance. High-quality materials have been used, combining Art Deco with contemporary notes, the collection's pieces getting a modern and stylish feel." ]
            ]
        , img [ src "./heron/4.jpg", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./heron/5.png", css [ width sizes.width, maxWidth (vw 100), marginTop (vw 4), marginBottom zero ] ] []
        , img [ src "./heron/6.png", css [ width sizes.width, maxWidth (vw 100), marginTop (vw 4), marginBottom zero ] ] []
        , img [ src "./heron/7.jpg", css [ width sizes.width, maxWidth (vw 100), marginTop (vw 4), marginBottom zero ] ] []
        , img [ src "./heron/8.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        ]


indagra sizes =
    div [ css [ width sizes.width, backgroundColor Color.vividRed, marginLeft sizes.leftMargin ] ]
        [ img [ src "./indagra/indagra1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./indagra/indagra2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./indagra/indagra4.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./indagra/indagra5.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , div [ css [ width sizes.textWidth, maxWidth (vw 100), fontSize sizes.fontSize, color Color.white, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ]
            [ p [ css [] ] [ text "New identity for INDAGRA SRL, a company specialized in passive fire protection. For their brand, Indagra wanted an identity that was minimal, professional and bold.   The aim was to create something bespoke as a reflection of the service level that they provide to their clients, being one of the best companies from their field of activity in Romania.  The symbol is a representation of a flame, with flat design style and modern gradients. The symbol is also a rethinked “i” letter, from Indagra." ]
            ]
        , img [ src "./indagra/indagra7.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginBottom zero ] ] []
        ]


astroCards sizes =
    div [ css [ width sizes.width, backgroundColor Color.black, marginLeft sizes.leftMargin ] ]
        [ img [ src "./astro/astro1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./astro/astro2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro3.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro4.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro5.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro6.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro7.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro8.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro9.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro10.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./astro/astro11.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginBottom zero ] ] []
        ]


bosch sizes =
    div [ css [ width sizes.width, backgroundColor Color.boschBlue, marginLeft sizes.leftMargin ] ]
        [ img [ src "./bosch/bosch1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./bosch/bosch2.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , div [ css [ width sizes.textWidth, maxWidth (vw 100), color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "Wall art collaboration project made for BOSCH Romania. I created 3 large mural illustrations for the IT office of BOSCH in Cluj-Napoca.  The main illustration represents a gigantic computer screen in a paralel fantasy universe, where the principal character (computer scientist), hunts down the bug monsters that are eating the code. Each and every detail refers to computer science (for example the sun is a wiFi planet, the trees have mother board branches and the clouds are storage spaces, collecting information from the imaginary IT universe). I wanted to create an atmosphere that captures the dynamism of the company ecosystem with some dedicated illustrations and a vivid color palette, showing that the IT life is not that boring as it seems." ]
        , img [ src "./bosch/bosch4.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./bosch/bosch5.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , div [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "The second wall illustration shows the importance of professionals and teamwork, which is the base of the company’s core values. Together, they build a world of IOT, where everything is connected. The details refer to the IT world also here (the stars are numbers of the binary ?)" ]
        , img [ src "./bosch/bosch7.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , div [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "The third illustration is a reinterpretation of Michelangelo’s  famous fresco painting, The Creation of Adam. It illustrates the creation of the machines, and the human is shown as God, the creator." ]
        , img [ src "./bosch/bosch9.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./bosch/bosch10.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./bosch/bosch11.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./bosch/bosch12.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./bosch/bosch13.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginBottom zero ] ] []
        ]


plasmo sizes =
    div [ css [ width sizes.width, backgroundColor Color.black, marginLeft sizes.leftMargin ] ]
        [ img [ src "./plasmo/plasmo1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./plasmo/plasmo2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo3.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo4.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , p [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), lineHeight (Css.em 2) ] ] [ text "Plasmo Life is a company that is specialized in Plasma Lifting, which is a non-invasive aesthetic answer to surgical lifting procedures, it activates skin cells by application of own plasma. Plasma biomaterial contains unique combination of highly effective substances – growth factors, thrombocytes, leukocyte and stem cells. They activate new cell production and regenerate damaged cells." ]
        , p [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "The goal was to create a visual identity system that is inspired by the blood cells and plasma, yet is not scary and inspires trust and professionalism." ]
        , img [ src "./plasmo/plasmo6.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo7.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo8.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo9.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo10.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./plasmo/plasmo11.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginBottom zero ] ] []
        ]


dochia sizes =
    div [ css [ width sizes.width, backgroundColor Color.dochiaPurple, marginLeft sizes.leftMargin ] ]
        [ img [ src "./dochia/dochia1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./dochia/dochia2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./dochia/dochia3.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./dochia/dochia4.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , p [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "Casa lu’ Dochia is a bed and breakfast located in Breb, a small village in Transylvania, Romania. It is characterized by rustic touches and traditional elements and its rural atmosphere. It gained its name from an old lady, called Dochia, who owned the house, where this small business is, before she died." ]
        , img [ src "./dochia/dochia7.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./dochia/dochia8.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        ]


crown sizes =
    div [ css [ width sizes.width, backgroundColor Color.white, marginLeft sizes.leftMargin ] ]
        [ img [ src "./crown/crown1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./crown/crown2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px 22) ] ] []
        , img [ src "./crown/crown3.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px 22) ] ] []
        , div [ css [ backgroundColor Color.iceBlue, marginTop (px 22), marginBottom (px 0) ] ] [ p [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), paddingTop <| px 40, paddingBottom <| px 40, marginBottom zero, lineHeight (Css.em 2) ] ] [ text "Inspired by a frosty winter morning, the Ice and wire headpiece tells the story of the Snow Queen. It combines aggressive, sharp materials, like glass and wire, hinted with glittery dust, providing a frozen icicle feel. This handcrafted statement headpiece was created as a university project." ] ]
        , img [ src "./crown/crown5.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px 22) ] ] []
        , img [ src "./crown/crown6.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px 22) ] ] []
        ]


ec sizes =
    div [ css [ width sizes.width, backgroundColor Color.white, marginLeft sizes.leftMargin ] ]
        [ img [ src "./ec/7sins1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./ec/7sins2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./ec/7sins3.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./ec/7sins4.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./ec/7sins5.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./ec/7sins6.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        ]


exlibris sizes =
    div [ css [ width sizes.width, backgroundColor Color.librisBlue, marginLeft sizes.leftMargin ] ]
        [ img [ src "./exlibris/exlibris1.png", css [ width sizes.width, maxWidth (vw 100), margin zero ] ] []
        , img [ src "./exlibris/exlibris2.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./exlibris/exlibris3.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./exlibris/exlibris4.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./exlibris/exlibris5.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./exlibris/exlibris6.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , p [ css [ width sizes.textWidth, color Color.inkBlue, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ text "An ex libris is a bookplate, than is usually a small print or decorative label pasted or stamped into a book, often on the front endpaper, to indicate its owner, with an unique design. An ex libris usually consist of the owner's name or monogram, and a motif that relates to the owner of the book. This project represents a very personal one, because it was made for my father, who loves and collects books in his home library." ]
        , img [ src "./exlibris/exlibris8.gif", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        , img [ src "./exlibris/exlibris9.png", css [ width sizes.width, maxWidth (vw 100), margin zero, marginTop (px -2) ] ] []
        ]


about messages sizes =
    div [ modalCss, onClick messages.closeModal ]
        [ div [ css [ width sizes.width, backgroundColor Color.black, color Color.white, marginLeft sizes.leftMargin ] ]
            [ img [ src "./cross.png", css [ height (px 16), width (px 16), position fixed, margin (px 20) ], onClick messages.closeModal ] []
            , img [ src "./blue.jpg", css [ width (vw 20), maxWidth (vw 100), margin <| vw 5, float left ] ] []
            , p [ css [ width sizes.textWidth, color Color.white, fontSize sizes.fontSize, marginLeft (vw 6), marginTop (vw 4), marginBottom (vw 4), lineHeight (Css.em 2) ] ] [ aboutText ]
            ]
        ]


aboutText : Html msg
aboutText =
    text "Hello. My name is Beata Csaka.  I am a multi-disciplinary designer, specialized in product, graphic and interior design.  I studied design at the University of Art and Design of Cluj-Napoca and Accademia di Belli Arti di Bari, Italy, obtaining my BA and MA degrees. I am always seeking for beauty and searching to find equilibrium in everything I do, whenever it is about materials, color palettes or proportions. My work distinguishes itself with the combination of mostly natural, bold, high quality materials and color schemes, while my love for minimalism is peppered with the combination of all kind of styles, depending on the project. Through the vast number of collaborations from various fields and diverse range of clients, I explore function, through the perspective of aesthetics.  I believes design is more than producing something, it is a journey, that requires some qualities along the way, that I consider I do have. First, curiosity, to question everything, to understand why things are the way they are. Then, courage to change them. Creativity to explore new concepts, forms and ideas. Discipline, to drive continual refinement. And the most important, passion, to be dedicated and enjoy the whole journey and deliver successful narratives through the visualization of my design work.  This online portfolio is a visual journey trough some of my projects! Enjoy it!"
