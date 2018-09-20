module Common exposing (edges, formatString)


formatString : String -> String
formatString str =
    str
        |> String.toLower
        |> String.filter Char.isAlpha


edges =
    { bottom = 0
    , left = 0
    , right = 0
    , top = 0
    }
