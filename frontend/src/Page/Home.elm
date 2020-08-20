module Page.Home exposing (LayoutConfig, viewLayout)

import Css exposing (Style, batch, rgb)
import CssTheme as CT
import Grid
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import Page.Home.NavbarSection as NavbarSection
import Section


viewLayout : LayoutConfig msg -> Html msg
viewLayout config =
    let
        sections =
            layoutSections config
    in
    div
        [ css [ layoutCSS (List.length sections) ] ]
        sections


type alias LayoutConfig msg =
    { stopAutocompleteMsg : msg
    , startSearchMsg : msg
    , sectionHeights : List Section.SectionHeight
    }


layoutSections : LayoutConfig msg -> List (Html msg)
layoutSections config =
    [ NavbarSection.viewNavbar config.stopAutocompleteMsg config.startSearchMsg
    , Section.viewSection (rgb 255 100 255) [] []
    , Section.viewSection (rgb 0 0 255) [] []
    ]
        |> List.map2
            (\height section -> section height)
            config.sectionHeights


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
        , CT.font
        ]
