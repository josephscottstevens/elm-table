module Main exposing (Person, main, persons)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input
import Element.Lazy


type alias Person =
    { firstName : String
    , lastName : String
    }


persons : List Person
persons =
    [ { firstName = "David"
      , lastName = "Bowie"
      }
    , { firstName = "Florence"
      , lastName = "Welch"
      }
    ]


main =
    Element.layout
        [ Font.italic
        , Font.size 32
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=EB+Garamond"
                , name = "EB Garamond"
                }
            , Font.sansSerif
            ]
        ]
    <|
        Element.table
            [ Element.centerX
            , Element.centerY
            , Element.spacing 5
            , Element.padding 10
            ]
            { data = persons
            , columns =
                [ { header = Element.text "First Name"
                  , width = px 200
                  , view =
                        \person ->
                            Element.text person.firstName
                  }
                , { header = Element.text "Last Name"
                  , width = fill
                  , view =
                        \person ->
                            Element.text person.lastName
                  }
                ]
            }
