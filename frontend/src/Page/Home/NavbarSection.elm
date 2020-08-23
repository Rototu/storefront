module Page.Home.NavbarSection exposing (viewNavbar)

import Css exposing (Style, batch)
import CssTheme as CT
import Grid
import Html.Styled exposing (Html, div, img)
import Html.Styled.Attributes as Attr
import Page.Home.Config exposing (LayoutConfig)
import Page.Home.SearchBar as SearchBar
import Section
import StyleTools as ST


viewNavbar : LayoutConfig msg -> Section.SectionHeight -> Html msg
viewNavbar config navbarHeight =
    Section.viewSection
        ST.white
        [ navbarCss ]
        [ logo
        , SearchBar.viewSearchInput config
        ]
        navbarHeight


navbarCss : Style
navbarCss =
    let
        rows =
            Grid.GRow [ Grid.Fraction 1 ]

        cols =
            Grid.GCol [ Grid.Fraction 1, Grid.Pixels CT.searchBarWidth, Grid.Fraction 1 ]
    in
    batch
        [ Grid.grid ( rows, cols )
        , Grid.placeItems Grid.Center Grid.Center
        ]


logo : Html msg
logo =
    div [] [ img [ Attr.src "../img/logo.png", Attr.height 50 ] [] ]
