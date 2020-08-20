module StyleTools exposing (black, clickable, fullHeight, fullWidth, noBorder, white)

import Css exposing (Color, Style, border2, cursor, height, none, pct, pointer, px, rgb, width)


fullWidth : Style
fullWidth =
    width (pct 100)


fullHeight : Style
fullHeight =
    height (pct 100)


white : Color
white =
    rgb 255 255 255


black : Color
black =
    rgb 0 0 0


noBorder : Style
noBorder =
    border2 (px 0) none


clickable : Style
clickable =
    cursor pointer
