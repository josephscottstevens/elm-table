module Table exposing (columnStyle, stringColumn, view)

import Common exposing (edges)
import Element exposing (rgb255)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font



-- https://www.datatables.net/media/images/sort_asc.png


stringColumn : String -> (record -> String) -> Element.IndexedColumn record msg
stringColumn headerString data =
    { header =
        Element.el
            [ Border.color (rgb255 55 55 55)
            , Border.widthEach { edges | bottom = 1 }
            , Border.solid
            , Element.paddingXY 10 8
            , Font.bold
            ]
            (Element.text headerString)
    , width = Element.fill
    , view = \idx t -> Element.el (columnStyle idx) (Element.text (data t))
    }


columnStyle idx =
    let
        altBackColor =
            if modBy 2 idx == 0 then
                Background.color (rgb255 250 250 250)

            else
                Background.color (rgb255 241 241 241)
    in
    [ Border.color (rgb255 221 221 221)
    , Border.widthEach { edges | top = 1 }
    , Border.solid
    , Font.color (rgb255 51 51 51)
    , Element.paddingXY 10 8
    , altBackColor
    ]


view data columns =
    Element.indexedTable
        [ Element.centerX
        , Border.color (rgb255 55 55 55)
        , Border.widthEach { edges | bottom = 1 }
        , Border.solid
        ]
        { data = data
        , columns =
            columns
        }
