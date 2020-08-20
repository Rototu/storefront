module Grid exposing (CellPosition(..), ColumnSizes(..), Grid, GridSize(..), RowSizes(..), centeredOneCellGrid, grid, placeItems)

import Css exposing (Style, batch, property)


type GridSize
    = Fraction Int
    | Pixels Int
    | AutoSize


type RowSizes
    = GRow (List GridSize)


type ColumnSizes
    = GCol (List GridSize)



-- different types for row and col to clarify order in Grid type


type alias Grid =
    ( RowSizes, ColumnSizes )


type CellPosition
    = AutoPos
    | Stretch
    | Start
    | End
    | Center


grid : Grid -> Style
grid ( rowSizes, colSizes ) =
    batch
        [ property "display" "grid"
        , property "grid-template-rows" <| parseRowSizes rowSizes
        , property "grid-template-columns" <| parseColSizes colSizes
        ]


parseRowSizes : RowSizes -> String
parseRowSizes (GRow sizes) =
    parseSizes sizes


parseColSizes : ColumnSizes -> String
parseColSizes (GCol sizes) =
    parseSizes sizes


parseSizes : List GridSize -> String
parseSizes sizes =
    sizes |> List.map parseSize |> String.join " "


parseSize : GridSize -> String
parseSize size =
    case size of
        Fraction n ->
            String.fromInt n ++ "fr"

        Pixels n ->
            String.fromInt n ++ "px"

        AutoSize ->
            "auto"


placeItems : CellPosition -> CellPosition -> Style
placeItems alignPos justifyPos =
    String.join " " [ parseCellPosition alignPos, parseCellPosition justifyPos ]
        |> property "place-items"


parseCellPosition : CellPosition -> String
parseCellPosition pos =
    case pos of
        AutoPos ->
            "auto"

        Stretch ->
            "stretch"

        Start ->
            "start"

        End ->
            "end"

        Center ->
            "center"


centeredOneCellGrid : Style
centeredOneCellGrid =
    batch
        [ grid ( GRow [ Fraction 1 ], GCol [ Fraction 1 ] )
        , placeItems Center Center
        ]
