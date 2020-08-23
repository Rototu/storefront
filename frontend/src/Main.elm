module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html.Styled exposing (toUnstyled)
import Page.Home
import Section exposing (SectionHeight(..))
import Url
import Page.Home.Config exposing (LayoutConfig)


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
init flags url key =
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


view : Model -> Browser.Document Msg
view model =
    { title = "Store Platform"
    , body = [ Page.Home.viewLayout homeViewConfig |> toUnstyled ]
    }


homeViewConfig : LayoutConfig Msg
homeViewConfig =
    { stopAutocompleteMsg = NoOp
    , startSearchMsg = NoOp
    , selectedSuggestionMsg = NoOp
    , sectionHeights = [ FixedPx 200, FixedPx 200, FixedPx 200 ]
    }
