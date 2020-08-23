module Section exposing (SectionHeight(..), viewSection)

import Css exposing (Color, Style, auto, backgroundColor, height, px)
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import StyleTools as ST


type SectionHeight
    = FixedPx Float
    | Auto


viewSection : Color -> List Style -> List (Html msg) -> SectionHeight -> Html msg
viewSection customColor customStyle children customPxHeight =
    div [ css (customStyle ++ sectionCSS customPxHeight customColor) ] children


parseSectionHeight : SectionHeight -> Style
parseSectionHeight h =
    case h of
        FixedPx val ->
            height (val |> px)

        Auto ->
            height auto


sectionCSS : SectionHeight -> Color -> List Style
sectionCSS customHeight customColor =
    [ ST.fullWidth
    , parseSectionHeight customHeight
    , backgroundColor customColor
    ]
