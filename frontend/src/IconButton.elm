module IconButton exposing (Icon(..), iconButton)

import Css exposing (Color, backgroundColor, color, hover, rgb)
import Css.Transitions exposing (easeInOut, transition)
import Grid
import Html.Styled exposing (Attribute, Html, div, fromUnstyled)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import StyleTools as ST


type Icon
    = Search
    | Stop


style : Color -> Attribute msg
style textColor =
    css
        [ color textColor
        , ST.fullWidth
        , ST.fullHeight
        , ST.clickable
        , Grid.centeredOneCellGrid
        , transition
            [ Css.Transitions.backgroundColor3 100 0 easeInOut
            ]
        , hover
            [ backgroundColor <| rgb 230 230 230
            ]
        ]


iconButton : Icon -> msg -> Int -> Color -> Html msg
iconButton icon clickMessage size iconColor =
    div
        [ style iconColor, onClick clickMessage ]
        [ viewIcon icon size ]


viewIcon : Icon -> Int -> Html msg
viewIcon icon size =
    case icon of
        Search ->
            Outlined.search size Inherit |> fromUnstyled

        Stop ->
            Outlined.close size Inherit |> fromUnstyled
