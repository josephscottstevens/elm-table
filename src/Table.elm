module Table exposing (RowsPerPage, State, defaultColumnStyle, init, view)

import Common exposing (edges)
import Element exposing (Element, rgb255)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input



-- Data Types


blockSize : Int
blockSize =
    15


init : String -> RowsPerPage -> State
init sortedColumnheader displayLength =
    { pageIndex = 0
    , rowsPerPage = displayLength
    , sortField = sortedColumnheader
    , sortAscending = True
    }


type RowsPerPage
    = Exactly Int
    | All


type alias State =
    { pageIndex : Int
    , rowsPerPage : RowsPerPage
    , sortField : String
    , sortAscending : Bool
    }


type ColumnStyle
    = NoStyle
    | Width Int
    | CustomStyle (List ( String, String ))


type Page
    = First
    | Previous
    | PreviousBlock
    | Index Int
    | NextBlock
    | Next
    | Last


type alias Column data msg =
    { header : String
    , viewData : Int -> data -> Element msg
    , columnStyle : ColumnStyle
    , sorter : Sorter data
    , columnId : String
    }


stringColumn : String -> (data -> String) -> ColumnStyle -> Column data msg
stringColumn header data columnStyle =
    { header = header
    , viewData = data >> (\t -> Element.text t)
    , columnStyle = columnStyle
    , sorter = increasingOrDecreasingBy data
    , columnId = header
    }



-- https://www.datatables.net/media/images/sort_asc.png
-- https://www.datatables.net/media/images/sort_both.png
-- https://www.datatables.net/media/images/sort_desc.png
-- VIEW
-- viewPagination : State -> (State -> msg) -> Element msg
-- viewPagination state toMsg =
--     let
--         optionLength =
--             viewSelect state.rowsPerPage
--     in
--     div
--         [ class "detailsEntitlementToolbar", id "searchResultsTable_length" ]
--         [ label []
--             [ text "Show "
--             , select [ id "pageLengthSelect", Events.onInput (\t -> toMsg { state | rowsPerPage = pageSelect t }) ]
--                 [ option
--                     [ value "50", selected (optionLength == "50") ]
--                     [ text "50" ]
--                 , option [ value "100", selected (optionLength == "100") ] [ text "100" ]
--                 , option [ value "150", selected (optionLength == "150") ] [ text "150" ]
--                 , option [ value "200", selected (optionLength == "200") ] [ text "200" ]
--                 , option [ value "-1", selected (optionLength == "-1") ] [ text "All" ]
--                 ]
--             ]
--         ]


view : State -> List data -> List (Column data msg) -> Element msg
view state rows columns =
    let
        sortedRows =
            sort state columns rows

        filteredRows =
            case state.rowsPerPage of
                Exactly rowsPerPage ->
                    sortedRows
                        |> List.drop (state.pageIndex * rowsPerPage)
                        |> List.take rowsPerPage

                All ->
                    sortedRows

        totalRows =
            List.length rows
    in
    Element.row []
        [ Element.indexedTable
            [ Element.centerX
            , Border.color (rgb255 55 55 55)
            , Border.widthEach { edges | bottom = 1 }
            , Border.solid
            ]
            { data = rows
            , columns = List.map customColumn columns
            }

        --, viewPagination state.rowsPerPage
        ]


customColumn : Column data msg -> Element.IndexedColumn data msg
customColumn column =
    { header =
        Element.row []
            [ Element.el
                [ Border.color (rgb255 55 55 55)
                , Border.widthEach { edges | bottom = 1 }
                , Border.solid
                , Element.paddingXY 10 8
                , Font.bold
                ]
                (Element.text column.header)
            , Element.image [ Element.alignRight ]
                { src = "https://www.datatables.net/media/images/sort_asc.png"
                , description = ""
                }
            ]
    , width = Element.fill
    , view = column.viewData --\idx t -> Element.el (columnStyle idx) (Element.text (data t))
    }


viewTh : State -> Column data msg -> (State -> msg) -> Element msg
viewTh state column toMsg =
    let
        sortUrl : String
        sortUrl =
            if state.sortField == column.columnId then
                if not state.sortAscending then
                    "https://www.datatables.net/media/images/sort_desc.png"

                else
                    "https://www.datatables.net/media/images/sort_asc.png"

            else
                "https://www.datatables.net/media/images/sort_both.png"
    in
    Element.row
        [ Events.onClick (toMsg { state | sortAscending = not state.sortAscending, sortField = column.columnId }) ]
        [ Element.image [ Element.alignRight ]
            { src = sortUrl
            , description = ""
            }
        , Element.text column.header
        ]


defaultColumnStyle : Int -> List (Element.Attribute msg)
defaultColumnStyle idx =
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



-- paging


getLastIndex : Int -> RowsPerPage -> Int
getLastIndex totalRows rowsPerPage =
    case rowsPerPage of
        Exactly t ->
            totalRows // t

        All ->
            if totalRows - 1 <= 0 then
                0

            else
                totalRows - 1


setPagingState : State -> Int -> (State -> msg) -> Page -> msg
setPagingState state totalRows toMsg page =
    let
        lastIndex =
            getLastIndex totalRows state.rowsPerPage

        bounded t =
            if t > lastIndex then
                lastIndex

            else if t < 0 then
                0

            else
                t

        newIndex =
            case page of
                First ->
                    0

                Previous ->
                    bounded (state.pageIndex - 1)

                PreviousBlock ->
                    bounded (state.pageIndex - blockSize)

                Index t ->
                    bounded t

                NextBlock ->
                    bounded (state.pageIndex + blockSize)

                Next ->
                    bounded (state.pageIndex + 1)

                Last ->
                    lastIndex
    in
    toMsg { state | pageIndex = newIndex }


pagerText : State -> Int -> String
pagerText state totalRows =
    let
        lastIndex =
            getLastIndex totalRows state.rowsPerPage

        currentPageText =
            String.fromInt (state.pageIndex + 1)

        totalPagesText =
            String.fromInt <|
                if lastIndex < 1 then
                    1

                else
                    lastIndex + 1

        totalItemsText =
            String.fromInt totalRows

        totalPageItems t =
            if (state.pageIndex + 1) * t > totalRows then
                totalRows

            else
                (state.pageIndex + 1) * t
    in
    case state.rowsPerPage of
        Exactly t ->
            "Showing " ++ String.fromInt (state.pageIndex * t + 1) ++ " to " ++ String.fromInt (totalPageItems t) ++ " of " ++ totalItemsText ++ " entries"

        All ->
            "Showing " ++ currentPageText ++ " to " ++ totalItemsText ++ " of " ++ totalPagesText ++ " entries"


pagingView : State -> Int -> List data -> (State -> msg) -> Element msg
pagingView state totalRows rows toMsg =
    let
        lastIndex =
            case state.rowsPerPage of
                Exactly t ->
                    totalRows // t

                All ->
                    0

        pagingStateClick page =
            setPagingState state totalRows toMsg page

        activeOrNot pageIndex =
            let
                maybeClick =
                    if pageIndex == state.pageIndex then
                        Just (pagingStateClick (Index pageIndex))

                    else
                        Nothing
            in
            Input.button []
                { onPress = maybeClick
                , label = Element.text (String.fromInt (pageIndex + 1))
                }

        rng =
            List.range 0 lastIndex
                |> List.drop ((state.pageIndex // blockSize) * blockSize)
                |> List.take blockSize
                |> List.map activeOrNot

        firstPageClick : Maybe msg
        firstPageClick =
            if state.pageIndex > 1 then
                Just <| pagingStateClick First

            else
                Nothing

        leftPageClick =
            if state.pageIndex > 0 then
                Just <| pagingStateClick Previous

            else
                Nothing

        rightPageClick =
            if state.pageIndex < lastIndex then
                Just <| pagingStateClick Next

            else
                Nothing

        lastPageClick =
            if state.pageIndex < lastIndex then
                Just <| pagingStateClick Last

            else
                Nothing
    in
    Element.row []
        [ Input.button []
            { onPress = firstPageClick
            , label = Element.text "First"
            }

        -- , Input.button []
        --     { onPress = leftPageClick
        --     , label = Element.text "Previous"
        --     }
        --  Element.row [] rng
        -- , Input.button []
        --     { onPress = rightPageClick
        --     , label = Element.text "Next"
        --     }
        -- , Input.button []
        --     { onPress = lastPageClick
        --     , label = Element.text "Last"
        --     }
        ]



-- Sorting


type Sorter data
    = None
    | IncOrDec (List data -> List data)


sort : State -> List (Column data msg) -> List data -> List data
sort state columnData data =
    case findSorter state.sortField columnData of
        Nothing ->
            data

        Just sorter ->
            applySorter state.sortAscending sorter data


applySorter : Bool -> Sorter data -> List data -> List data
applySorter isReversed sorter data =
    case sorter of
        None ->
            data

        IncOrDec sortOp ->
            if isReversed then
                List.reverse (sortOp data)

            else
                sortOp data


findSorter : String -> List (Column data msg) -> Maybe (Sorter data)
findSorter selectedColumn columnData =
    case columnData of
        [] ->
            Nothing

        { columnId, sorter } :: remainingColumnData ->
            if columnId == selectedColumn then
                Just sorter

            else
                findSorter selectedColumn remainingColumnData


increasingOrDecreasingBy : (data -> comparable) -> Sorter data
increasingOrDecreasingBy toComparable =
    IncOrDec (List.sortBy toComparable)


defaultSort : (data -> Maybe String) -> Sorter data
defaultSort t =
    increasingOrDecreasingBy (Maybe.withDefault "" << t)


intSort : (data -> Int) -> Sorter data
intSort t =
    increasingOrDecreasingBy (String.fromInt << t)
