module Main exposing (main)

import Browser
import Common exposing (formatString)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Lazy
import Html exposing (Html)
import People exposing (..)
import Table


type alias Model =
    { searchText : String
    , tableState : Table.State
    }


emptyModel : Model
emptyModel =
    { searchText = ""
    , tableState = Table.init "Name" (Table.Exactly 10) --Table.All
    }


type Msg
    = UpdateSearch String
    | UpdateTableState Table.State


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateSearch str ->
            { model | searchText = str }

        UpdateTableState tableState ->
            { model | tableState = tableState }


view : Model -> Html Msg
view model =
    let
        rows =
            filter model.searchText people
    in
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
                [ Input.text []
                    { onChange = UpdateSearch
                    , text = model.searchText
                    , placeholder = Nothing
                    , label =
                        Input.labelLeft
                            [ centerY
                            , paddingXY 8 2
                            ]
                            (text "Search: ")
                    }
                ]
            , Table.view
                model.tableState
                UpdateTableState
                rows
                [ Table.stringColumn "Name" .name Table.Auto
                , Table.stringColumn "Phone" .phone Table.Auto
                , Table.stringColumn "Company" .company Table.Auto
                , Table.stringColumn "Address" .address Table.Auto
                , Table.stringColumn "City" .city Table.Auto
                ]
            , Table.pagingView model.tableState UpdateTableState rows
            ]


main =
    Browser.sandbox { init = emptyModel, update = update, view = view }


filter : String -> List Person -> List Person
filter filterString people =
    people
        |> List.filter (\p -> String.contains (formatString filterString) (personToStringFormatted p))
