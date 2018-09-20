module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
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
        column [ width fill ]
            [ row [ centerY ]
                [ Input.text []
                    { onChange = UpdateSearch
                    , text = model.searchText
                    , placeholder = Nothing
                    , label = Input.labelLeft [ centerY ] (text "Search: ")
                    }
                ]
            , Element.table
                [ Element.centerX
                , Element.spacing 5
                , Element.padding 10
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


stringColumn : String -> (record -> String) -> Column record msg
stringColumn headerString data =
    { header = Element.text headerString
    , width = fill
    , view = data >> (\t -> Element.text t)
    }


filter : String -> List Person -> List Person
filter filterString people =
    people
        |> List.filter (\p -> String.contains (formatString filterString) (personToStringFormatted p))
