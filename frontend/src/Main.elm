module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Css.Transitions exposing (easeInOut, transition)
import Grid
import Html.Styled exposing (Attribute, Html, div, fromUnstyled, img, input, toUnstyled)
import Html.Styled.Attributes as Attr
import Html.Styled.Events exposing (onClick)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import StyleTools as ST
import Url



-- MAIN


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



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , selected : Maybe AutocompleteSuggestion
    , error : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url Nothing "", Cmd.none )



-- UPDATE


type alias AutocompleteSuggestion =
    String


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


type alias Attributes msg =
    List (Attribute msg)


type alias Htmls msg =
    List (Html msg)


view : Model -> Browser.Document Msg
view model =
    { title = "Store Platform"
    , body = [ layoutSections model |> renderLayout |> toUnstyled ]
    }


renderLayout : Htmls Msg -> Html Msg
renderLayout sections =
    div
        [ Attr.css [ layoutCSS (List.length sections) ] ]
        sections


layoutSections : Model -> Htmls Msg
layoutSections model =
    [ renderSection 200 ST.white [ navbarCss ] [ logo, searchinput model ]
    , renderSection 100 (rgb 255 100 255) [] []
    , renderSection 100 (rgb 0 0 255) [] []
    ]


renderSection : Int -> Color -> List Style -> Htmls Msg -> Html Msg
renderSection customPxHeight customColor customStyle children =
    div [ Attr.css (customStyle ++ sectionCSS customPxHeight customColor) ] children


sectionCSS : Int -> Color -> List Style
sectionCSS customHeight customColor =
    [ ST.fullWidth
    , height (customHeight |> toFloat |> px)
    , backgroundColor customColor
    ]


layoutCSS : Int -> Style
layoutCSS sectionCount =
    let
        rows =
            List.repeat sectionCount Grid.AutoSize |> Grid.GRow

        cols =
            Grid.GCol [ Grid.Fraction 1 ]
    in
    batch
        [ Grid.grid ( rows, cols )
        , fontFamilies [ qt "Roboto", .value sansSerif ]
        ]


navbarCss : Style
navbarCss =
    let
        rows =
            Grid.GRow [ Grid.Fraction 1 ]

        cols =
            [ 2, 8, 2 ]
                |> List.map Grid.Fraction
                |> Grid.GCol
    in
    batch
        [ Grid.grid ( rows, cols )
        , Grid.placeItems Grid.Center Grid.Center
        ]


logo : Html Msg
logo =
    div [] [ img [ Attr.src "../img/logo.png", Attr.height 50 ] [] ]


searchinput : Model -> Html Msg
searchinput model =
    div
        [ Attr.css [ searchinputCss ] ]
        (searchComponents model)


searchComponents : Model -> Htmls Msg
searchComponents model =
    [ inputField model
    , iconButton CancelIcon NoOp 20 ST.black
    , iconButton SearchIcon NoOp 20 ST.black
    ]


inputField : Model -> Html Msg
inputField model =
    let
        styles =
            Attr.css
                [ ST.fullWidth
                , ST.fullHeight
                , outline none
                , ST.noBorder
                , boxSizing borderBox
                , fontFamily inherit
                , fontSize (rem 1)
                , padding2 (px 0) (px 10)
                ]
    in
    input [ styles ] []


searchinputCss : Style
searchinputCss =
    let
        rows =
            Grid.GRow [ Grid.Fraction 1 ]

        cols =
            Grid.GCol [ Grid.Fraction 10, Grid.Pixels 40, Grid.Pixels 40 ]
    in
    batch
        [ Grid.grid ( rows, cols )
        , ST.fullWidth
        , height (px 50)
        , border3 (px 2) solid ST.black
        , padding (px 1)
        ]


type Icon
    = SearchIcon
    | CancelIcon


iconButton : Icon -> Msg -> Int -> Color -> Html Msg
iconButton icon clickMessage size iconColor =
    let
        style =
            Attr.css
                [ color iconColor
                , ST.fullWidth
                , ST.fullHeight
                , ST.clickable
                , Grid.centeredOneCellGrid
                , hoverStyle
                , transition
                    [ Css.Transitions.backgroundColor3 200 0 easeInOut
                    ]
                ]

        hoverStyle =
            hover
                [ backgroundColor <| rgb 230 230 230
                ]
    in
    case icon of
        SearchIcon ->
            div
                [ style, onClick clickMessage ]
                [ Outlined.search size Inherit |> fromUnstyled ]

        CancelIcon ->
            div
                [ style, onClick clickMessage ]
                [ Outlined.close size Inherit |> fromUnstyled ]
