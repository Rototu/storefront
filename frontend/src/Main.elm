module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Autocomplete
import Browser
import Browser.Navigation as Nav
import Html exposing (Attribute, Html, div, img, input)
import Html.Attributes exposing (height, src)
import Html.Events exposing (onClick)
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
    , autocomplete : Autocomplete.Autocomplete AutocompleteSuggestion
    , selected : Maybe AutocompleteSuggestion
    , error : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url (Autocomplete.init "") Nothing "", Cmd.none )



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
    { title = "URL Interceptor"
    , body = [ layoutSections model |> renderLayout ]
    }


renderLayout : Htmls Msg -> Html Msg
renderLayout sections =
    div (layoutCSS (List.length sections)) sections


layoutSections : Model -> Htmls Msg
layoutSections model =
    [ renderSection 200 ST.white navbarCss [ logo, searchinput model ]
    , renderSection 100 (ST.RgbColor 255 100 255) [] []
    , renderSection 100 (ST.RgbColor 0 0 255) [] []
    ]


renderSection : Int -> ST.Color -> Attributes Msg -> Htmls Msg -> Html Msg
renderSection customPxHeight customColor customStyle children =
    div (customStyle ++ sectionCSS customPxHeight customColor) children


sectionCSS : Int -> ST.Color -> Attributes Msg
sectionCSS customHeight customColor =
    ST.styles
        [ ST.fullWidth
        , ST.height customHeight ST.Px
        , ST.backgroundColor customColor
        ]


layoutCSS : Int -> Attributes Msg
layoutCSS sectionCount =
    let
        rows =
            ST.FastGrid sectionCount ST.Auto

        cols =
            ST.FastGrid 1 ST.Equal
    in
    ST.grid ( rows, cols )


navbarCss : Attributes Msg
navbarCss =
    let
        rows =
            ST.FastGrid 1 ST.Auto

        cols =
            ST.CustomGrid [ "2fr", "8fr", "2fr" ]
    in
    ST.grid ( rows, cols )


logo : Html Msg
logo =
    div [] [ img [ src "../img/logo.png", height 50 ] [] ]



searchinput : Model -> Html Msg
searchinput model =
    div searchinputCss (searchComponents model)


searchComponents : Model -> Htmls Msg
searchComponents model =
    [ inputField model
    , iconButton CancelIcon NoOp 20 ST.black
    , iconButton SearchIcon NoOp 20 ST.black
    ]

inputField : Model -> Html Msg
inputField model = 
    let
        styles = ST.styles [ST.fullWidth, ST.fullHeight, ("outline", "none"), ST.noBorder, ST.borderBox]
    in
    input styles []

searchinputCss : Attributes Msg
searchinputCss =
    let
        rows =
            ST.FastGrid 1 ST.Equal

        cols =
            ST.CustomGrid [ "10fr", "40px", "40px" ]
    in
    ST.grid ( rows, cols ) ++ ST.styles [ ST.fullWidth, ST.height 50 ST.Px, ST.borderBottom 3 ST.black ]


type Icon
    = SearchIcon
    | CancelIcon


iconButton : Icon -> Msg -> Int -> ST.Color -> Html Msg
iconButton icon clickMessage size color =
    let
        style =
            ST.styles [ ST.textColor color, ST.fullWidth, ST.fullHeight, ST.pointerCursor ] ++ ST.centerContentGrid
    in
    case icon of
        SearchIcon ->
            div
                (style ++ [ onClick clickMessage ])
                [ Outlined.search size Inherit ]

        CancelIcon ->
            div
                (style ++ [ onClick clickMessage ])
                [ Outlined.cancel size Inherit ]
