module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Lazy
import People exposing (..)


type alias Model =
    { searchText : String
    }


emptyModel : Model
emptyModel =
    { searchText = "" }


type Msg
    = UpdateSearch String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateSearch str ->
            { model | searchText = str }


view model =
    Element.layout
        [ Font.size 18
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=EB+Garamond"
                , name = "EB Garamond"
                }
            , Font.sansSerif
            ]
        ]
    <|
        column [ width fill, padding 40 ]
            [ row [ centerY ]
                [ Input.text [ Font.size 12 ]
                    { onChange = UpdateSearch
                    , text = model.searchText
                    , placeholder = Nothing
                    , label =
                        Input.labelLeft
                            [ centerY
                            , Font.size 18
                            , paddingXY 8 2
                            ]
                            (text "Search: ")
                    }
                ]
            , Element.indexedTable
                [ Element.centerX
                , Border.color (rgb255 55 55 55)
                , Border.widthEach { edges | bottom = 1 }
                , Border.solid
                ]
                { data = filter model.searchText people
                , columns =
                    [ stringColumn "Name" .name
                    , stringColumn "Phone" .phone
                    , stringColumn "Company" .company
                    , stringColumn "Address" .address
                    , stringColumn "City" .city
                    ]
                }
            ]


main =
    Browser.sandbox { init = emptyModel, update = update, view = view }


edges =
    { bottom = 0
    , left = 0
    , right = 0
    , top = 0
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
    , paddingXY 10 8
    , altBackColor
    ]


stringColumn : String -> (record -> String) -> IndexedColumn record msg
stringColumn headerString data =
    { header =
        el
            [ Border.color (rgb255 55 55 55)
            , Border.widthEach { edges | bottom = 1 }
            , Border.solid
            , paddingXY 10 8
            , Font.bold
            ]
            (Element.text headerString)
    , width = fill
    , view = \idx t -> el (columnStyle idx) (Element.text (data t))
    }


filter : String -> List Person -> List Person
filter filterString people =
    people
        |> List.filter (\p -> String.contains (formatString filterString) (personToStringFormatted p))
