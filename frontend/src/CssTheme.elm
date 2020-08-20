module CssTheme exposing (font, mainFontSize, smallButtonIconSize, themeColor)

import Css exposing (Color, Px, Style, fontFamilies, px, qt, rgb, sansSerif)
import StyleTools as ST


smallButtonIconSize : Int
smallButtonIconSize =
    20


themeColor : { text : Color, main : Color }
themeColor =
    { text = ST.black
    , main = rgb 0 0 100
    }


mainFontSize : Px
mainFontSize =
    px 20


font : Style
font =
    fontFamilies [ qt "Roboto", .value sansSerif ]
