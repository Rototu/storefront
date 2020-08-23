module Page.Home.Config exposing (LayoutConfig)

import Section


type alias LayoutConfig msg =
    { stopAutocompleteMsg : msg
    , startSearchMsg : msg
    , selectedSuggestionMsg : msg
    , sectionHeights : List Section.SectionHeight
    }
