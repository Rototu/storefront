module StyleTools exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)


type alias CSS =
    ( String, String )


type CssUnit
    = Px
    | Percentage


type Color
    = RgbColor Int Int Int
    | HexColor String


type GridSizes
    = FastGrid Int CellSize
    | CustomGrid (List String)


type alias Grid =
    ( GridSizes, GridSizes )


type CellSize
    = Auto
    | Equal


parseColor : Color -> String
parseColor color =
    case color of
        RgbColor r g b ->
            rgb r g b

        HexColor val ->
            val


backgroundColor : Color -> CSS
backgroundColor color =
    ( "background-color", parseColor color )


textColor : Color -> CSS
textColor color =
    ( "text-color", parseColor color )


rgb : Int -> Int -> Int -> String
rgb r g b =
    "rgb(" ++ String.fromInt r ++ "," ++ String.fromInt g ++ "," ++ String.fromInt b ++ ")"


fullWidth : CSS
fullWidth =
    width 100 Percentage


fullHeight : CSS
fullHeight =
    height 100 Percentage


width : Int -> CssUnit -> CSS
width size unit =
    case unit of
        Px ->
            ( "width", toPx size )

        Percentage ->
            ( "width", toPercentage size )


height : Int -> CssUnit -> CSS
height size unit =
    case unit of
        Px ->
            ( "height", toPx size )

        Percentage ->
            ( "height", toPercentage size )


toPx : Int -> String
toPx val =
    String.fromInt val ++ "px"


toPercentage : Int -> String
toPercentage val =
    String.fromInt val ++ "%"


grid : Grid -> List (Attribute msg)
grid ( gRows, gCols ) =
    styles
        [ ( "display", "grid" )
        , ( "grid-template-columns", parseGridSizes gCols )
        , ( "grid-template-rows", parseGridSizes gRows )
        , ( "place-items", "center" )
        ]


centerContentGrid : List (Attribute msg)
centerContentGrid =
    let
        rows =
            FastGrid 1 Equal

        cols =
            FastGrid 1 Equal
    in
    grid ( rows, cols )


parseGridSizes : GridSizes -> String
parseGridSizes size =
    case size of
        FastGrid repeatCount cellType ->
            gridRepeat repeatCount cellType

        CustomGrid sizes ->
            String.join " " sizes |> testGridSize


testGridSize : String -> String
testGridSize size =
    if String.length size <= 1 then
        "1fr"

    else
        size


styles : List CSS -> List (Attribute msg)
styles cssList =
    List.map (uncurry style) cssList


uncurry : (a -> b -> c) -> ( a, b ) -> c
uncurry f ( a, b ) =
    f a b


gridRepeat : Int -> CellSize -> String
gridRepeat times size =
    case size of
        Auto ->
            "repeat(" ++ String.fromInt times ++ ", auto)"

        Equal ->
            "repeat(" ++ String.fromInt times ++ ", 1fr)"


white : Color
white =
    HexColor "#FFFFFF"


black : Color
black =
    HexColor "#000000"


noBorder : CSS
noBorder =
    ( "border", "none" )


borderBox : CSS
borderBox =
    ( "box-sizing", "border-box" )


border : Int -> Color -> CSS
border size color =
    ( "border", String.fromInt size ++ "px solid " ++ parseColor color )


borderBottom : Int -> Color -> CSS
borderBottom size color =
    ( "border-bottom", String.fromInt size ++ "px solid " ++ parseColor color )


borderRadius : Int -> CSS
borderRadius radius =
    ( "border-radius", String.fromInt radius ++ "px" )


pointerCursor : CSS
pointerCursor =
    ( "cursor", "pointer" )
