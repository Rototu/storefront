module Page.Home.SearchBar exposing (searchInput)

import Css exposing (Color, Style, border3, borderBox, boxSizing, fontFamily, fontSize, height, inherit, none, outline, padding, padding2, px, rem, solid)
import CssTheme as CT
import Grid
import Html.Styled exposing (Attribute, Html, div, input)
import Html.Styled.Attributes exposing (css)
import IconButton
import StyleTools as ST


searchInput : msg -> msg -> Html msg
searchInput stopAutocompleteMsg startSearchMsg =
    div
        [ searchInputCss ]
        (searchComponents stopAutocompleteMsg startSearchMsg)


searchInputCss : Attribute msg
searchInputCss =
    css
        [ searchInputGridLayout
        , ST.fullWidth
        , height (px 50)
        , border3 (px 2) solid ST.black
        , padding (px 1)
        ]


searchInputGridLayout : Style
searchInputGridLayout =
    let
        rows =
            Grid.GRow [ Grid.Fraction 1 ]

        cols =
            Grid.GCol [ Grid.Fraction 10, Grid.Pixels 40, Grid.Pixels 40 ]
    in
    Grid.grid ( rows, cols )


searchComponents : msg -> msg -> List (Html msg)
searchComponents stopAutocompleteMsg startSearchMsg =
    [ inputField
    , searchbarIcon IconButton.Stop stopAutocompleteMsg
    , searchbarIcon IconButton.Search startSearchMsg
    ]


searchbarIcon : IconButton.Icon -> msg -> Html msg
searchbarIcon icon clickMessage =
    IconButton.iconButton icon clickMessage iconSize iconColor


iconSize : Int
iconSize =
    CT.smallButtonIconSize


iconColor : Color
iconColor =
    CT.themeColor.main


inputField : Html msg
inputField =
    input [ inputCss ] []


inputCss : Attribute msg
inputCss =
    css
        [ ST.fullWidth
        , ST.fullHeight
        , outline none
        , ST.noBorder
        , boxSizing borderBox
        , fontFamily inherit
        , fontSize (rem 1)
        , padding2 (px 0) (px 10)
        ]
