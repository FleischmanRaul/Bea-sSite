module Main exposing (..)

-- import Action

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src, style)
import Html.Styled.Events exposing (onClick)
import Random
import Url
import Url.Parser as Url exposing ((</>), Parser)



---- MODEL ----


type Page
    = Home
    | Contact


type alias Model =
    { navKey : Nav.Key
    , page : Page
    , counter : Int
    , menuOn : Bool
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { navKey = key
      , page = urlToPage url
      , counter = 1
      , menuOn = False
      }
    , Cmd.none
    )



---- UPDATE ----


urlToPage : Url.Url -> Page
urlToPage url =
    -- We start with our URL
    url
        -- Send it through our URL parser (located below)
        |> Url.parse urlParser
        -- And if it didn't match any known pages, return Index
        |> Maybe.withDefault Home


urlParser : Parser (Page -> a) a
urlParser =
    -- We try to match one of the following URLs
    Url.oneOf
        -- Url.top matches root (i.e. there is nothing after 'https://example.com')
        [ Url.map Home Url.top

        -- Url.s matches URLs ending with some string, in our case '/contact'
        , Url.map Contact (Url.s "contact")
        ]


type Msg
    = Roll
    | NewFace Int
    | TogleMenu
    | LinkClicked UrlRequest
    | UrlChange Url.Url
    | OpenContactPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model model.navKey model.page newFace model.menuOn
            , Cmd.none
            )

        TogleMenu ->
            ( Model model.navKey model.page model.counter (not model.menuOn)
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                External url ->
                    ( model
                    , Cmd.none
                    )

        UrlChange url ->
            ( { model | page = urlToPage url }
            , Cmd.none
            )

        OpenContactPage ->
            ( model
            , Nav.pushUrl model.navKey "/contact"
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


beaLogo =
    img [ src "./bea_logo.png", css [ margin (px 100), height (vmin 60), width (vmin 60), maxWidth (vw 100) ] ] []


row =
    div [ css [ maxWidth (vw 100) ] ]
        [ img [ src "./pink.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./blue.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./gray.jpeg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./pink.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./blue.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./gray.jpeg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./pink.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./blue.jpg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        , img [ src "./gray.jpeg", css [ margin (px 1), height (vmax 30), width (vmax 30), maxWidth (vw 100) ] ] []
        ]


home model =
    nav [ css [ cursor crosshair ] ]
        [ menu model
        , beaLogo
        , row
        ]


currentPage model =
    case model.page of
        Home ->
            home model

        Contact ->
            text "Bea vagyok!"


view : Model -> Browser.Document Msg
view model =
    let
        body =
            currentPage model
    in
    { body = [ Html.Styled.toUnstyled body ]
    , title = "title"
    }


menuHoverButton : Html.Styled.Html Msg
menuHoverButton =
    a
        [ onClick TogleMenu
        , css
            [ hover
                [ backgroundColor (rgb 0 0 0)
                , color (rgb 255 255 255)
                ]
            , padding (px 10)
            ]
        ]
        [ text "Open/Close " ]


menu : Model -> Html.Styled.Html Msg
menu model =
    if model.menuOn then
        div
            [ css [ padding (px 10), fontSize (px 24) ]
            , style "-webkit-user-select" "none"
            , style "-moz-user-select" "none"
            , style "-ms-user-select" "none"
            , style "user-select" "none"
            ]
            [ menuHoverButton
            , a
                [ onClick Roll
                , css
                    [ margin (px 10)
                    , hover
                        [ backgroundColor (rgb 0 0 0)
                        , color (rgb 255 255 255)
                        ]
                    ]
                ]
                [ text "home" ]
            , a
                [ onClick Roll
                , css
                    [ margin (px 10)
                    , hover
                        [ backgroundColor (rgb 0 0 0)
                        , color (rgb 255 255 255)
                        ]
                    ]
                ]
                [ text "projects" ]
            , a
                [ onClick OpenContactPage
                , css
                    [ margin (px 10)
                    , hover
                        [ backgroundColor (rgb 0 0 0)
                        , color (rgb 255 255 255)
                        ]
                    ]
                ]
                [ text "contact" ]
            ]

    else
        div [ css [ padding (px 10), fontSize (px 24) ] ] [ menuHoverButton ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChange
        }


{-| A plain old record holding a couple of theme colors.
-}
theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "11111"
    , secondary = rgb 150 140 230
    }


{-| A reusable button which has some styles pre-applied to it.
-}
btn : List (Attribute msg) -> List (Html msg) -> Html msg
btn =
    styled button
        [ margin (px 12)
        , color (rgb 50 50 50)
        , hover
            [ backgroundColor theme.primary
            , textDecoration underline
            ]
        ]
