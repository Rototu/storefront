module CssTheme exposing (autocompleteContainerHeight, borderWidth, font, mainFontSize, navItemHeight, searchBarWidth, searchPadding, smallButtonIconSize, themeColor)

import Css
import StyleTools as ST


smallButtonIconSize : Int
smallButtonIconSize =
    20


themeColor : { text : Css.Color, main : Css.Color }
themeColor =
    { text = ST.black
    , main = Css.rgb 0 0 100
    }


mainFontSize : Css.Px
mainFontSize =
    Css.px 20


font : Css.Style
font =
    Css.fontFamilies [ Css.qt "Roboto", .value Css.sansSerif ]


navItemHeight : Float
navItemHeight =
    50


borderWidth : Float
borderWidth =
    2


autocompleteContainerHeight : Css.Rem
autocompleteContainerHeight =
    Css.rem 2


searchPadding : Float
searchPadding =
    10


searchBarWidth : Int
searchBarWidth =
    400
