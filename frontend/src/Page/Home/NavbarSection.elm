module Page.Home.NavbarSection exposing (viewNavbar)

import Css exposing (Style, batch)
import Grid
import Html.Styled exposing (Html, div, img)
import Html.Styled.Attributes as Attr
import Page.Home.SearchBar as SearchBar
import Section
import StyleTools as ST


viewNavbar : msg -> msg -> Section.SectionHeight -> Html msg
viewNavbar stopAutocompleteMsg startSearchMsg navbarHeight =
    Section.viewSection
        ST.white
        [ navbarCss ]
        [ logo, SearchBar.searchInput stopAutocompleteMsg startSearchMsg ]
        navbarHeight


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


logo : Html msg
logo =
    div [] [ img [ Attr.src "../img/logo.png", Attr.height 50 ] [] ]
