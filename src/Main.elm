module Main exposing (main)

import Browser
import Common exposing (formatString)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Lazy
import People exposing (..)
import Table


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
                            , paddingXY 8 2
                            , Font.size 18
                            ]
                            (text "Search: ")
                    }
                ]
            , Table.view
                (filter model.searchText people)
                [ Table.stringColumn "Name" .name
                , Table.stringColumn "Phone" .phone
                , Table.stringColumn "Company" .company
                , Table.stringColumn "Address" .address
                , Table.stringColumn "City" .city
                ]
            ]


main =
    Browser.sandbox { init = emptyModel, update = update, view = view }


filter : String -> List Person -> List Person
filter filterString people =
    people
        |> List.filter (\p -> String.contains (formatString filterString) (personToStringFormatted p))
