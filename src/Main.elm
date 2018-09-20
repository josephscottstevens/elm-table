module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Element.Lazy
import People exposing (..)


main =
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
            [ row []
                [ Input.text []
                    { onChange = UpdateSearch
                    , text = model.searchText
                    , placeHolder = Just (text "search")
                    , label = Input.labelLeft [] (text "Search: ")
                    }
                ]
            , Element.table
                [ Element.centerX
                , Element.spacing 5
                , Element.padding 10
                ]
                { data = people
                , columns =
                    [ { header = Element.text "Name"
                      , width = px 200
                      , view =
                            \person ->
                                Element.text person.name
                      }
                    , { header = Element.text "Phone"
                      , width = fill
                      , view =
                            \person ->
                                Element.text person.phone
                      }
                    , { header = Element.text "Company"
                      , width = fill
                      , view =
                            \person ->
                                Element.text person.company
                      }
                    ]
                }
            ]
