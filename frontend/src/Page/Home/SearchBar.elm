module Page.Home.SearchBar exposing (viewSearchInput)

import Css
import Css.Transitions exposing (easeInOut, transition)
import CssTheme as CT
import Grid
import Html.Styled exposing (Attribute, Html, div, input, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import IconButton
import MockData
import Page.Home.Config exposing (LayoutConfig)
import StyleTools as ST


viewSearchInput : LayoutConfig msg -> Html msg
viewSearchInput config =
    div
        [ searchInputCss ]
        (viewSearchComponents config)


searchInputCss : Attribute msg
searchInputCss =
    css
        [ searchInputGridLayoutCss
        , ST.fullWidth
        , Css.height (CT.navItemHeight |> Css.px)
        , Css.border3 (CT.borderWidth |> Css.px) Css.solid ST.black
        , Css.padding (1 |> Css.px)
        ]


searchInputGridLayoutCss : Css.Style
searchInputGridLayoutCss =
    let
        rows =
            Grid.GRow [ Grid.Fraction 1 ]

        cols =
            Grid.GCol [ Grid.Fraction 10, Grid.Pixels 40, Grid.Pixels 40 ]
    in
    Grid.grid ( rows, cols )


viewSearchComponents : LayoutConfig msg -> List (Html msg)
viewSearchComponents config =
    [ viewInputField (\_ -> config.selectedSuggestionMsg)
    , viewSearchbarIcon IconButton.Stop config.stopAutocompleteMsg
    , viewSearchbarIcon IconButton.Search config.startSearchMsg
    ]


viewSearchbarIcon : IconButton.Icon -> msg -> Html msg
viewSearchbarIcon icon clickMessage =
    IconButton.iconButton icon clickMessage iconSize iconColor


iconSize : Int
iconSize =
    CT.smallButtonIconSize


iconColor : Css.Color
iconColor =
    CT.themeColor.main


viewInputField : (Int -> msg) -> Html msg
viewInputField selectedMsg =
    let
        fieldCss =
            css
                [ ST.fullWidth
                , ST.fullHeight
                , Css.position Css.relative
                ]

        viewTextInput =
            input [ inputCss ] []

        viewSelectionOptions =
            viewAutocompleteVals MockData.fruitList selectedMsg
    in
    div [ fieldCss ] [ viewTextInput, viewSelectionOptions ]


inputCss : Attribute msg
inputCss =
    css
        [ ST.fullWidth
        , ST.fullHeight
        , Css.outline Css.none
        , ST.noBorder
        , Css.boxSizing Css.borderBox
        , Css.fontFamily Css.inherit
        , Css.fontSize (1 |> Css.rem)
        , Css.padding2 (0 |> Css.px) (CT.searchPadding |> Css.px)
        ]


viewAutocompleteVals : List String -> (Int -> msg) -> Html msg
viewAutocompleteVals suggestions msg =
    let
        maxSuggestionCount = 5
        viewOptions =
            List.take maxSuggestionCount suggestions |> List.indexedMap (viewSuggestion msg)

        customStyle =
            List.take maxSuggestionCount suggestions |> List.length |> autocompleteValsCss
    in
    div [ customStyle ] viewOptions


autocompleteValsCss : Int -> Attribute msg
autocompleteValsCss rowCount =
    let
        rows =
            Grid.Fraction 1 |> List.repeat rowCount |> Grid.GRow

        cols =
            Grid.GCol [ Grid.Fraction 1 ]
    in
    css
        [ Grid.grid ( rows, cols )
        , Css.width (CT.searchBarWidth + 2 |> toFloat |> Css.px)
        , Css.position Css.absolute
        , Css.top (CT.navItemHeight |> Css.px)
        , Css.left (-CT.borderWidth - 1 |> Css.px)
        , Css.borderLeft3 (CT.borderWidth |> Css.px) Css.solid ST.black
        , Css.borderBottom3 (CT.borderWidth |> Css.px) Css.solid ST.black
        , Css.borderRight3 (CT.borderWidth |> Css.px) Css.solid ST.black
        ]


viewSuggestion : (Int -> msg) -> Int -> String -> Html msg
viewSuggestion msg index content =
    div
        [ msg index |> onClick
        , suggestionCss
        ]
        [ text content ]


suggestionCss : Attribute msg
suggestionCss =
    let
        rows =
            Grid.GRow [ Grid.Fraction 1 ]

        cols =
            Grid.GCol [ Grid.Fraction 1 ]

        grid =
            Grid.grid ( rows, cols )
    in
    css
        [ ST.fullWidth
        , Css.height CT.autocompleteContainerHeight
        , ST.clickable
        , Css.backgroundColor ST.white
        , Css.boxSizing Css.borderBox
        , Css.padding2 (0 |> Css.px) (CT.searchPadding |> Css.px)
        , grid
        , Grid.placeItems Grid.Center Grid.Start
        , transition
            [ Css.Transitions.backgroundColor3 20 0 easeInOut ]
        , Css.hover
            [ Css.rgb 230 230 230 |> Css.backgroundColor ]
        ]
