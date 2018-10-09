module Table exposing (ColumnStyle(..), RowsPerPage(..), State, defaultColumnStyle, init, pagingView, stringColumn, view)

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
init sortedColumnheader rowsPerPage =
    { pageIndex = 0
    , rowsPerPage = rowsPerPage
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
    | Auto
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
    , viewData : data -> Element msg
    , columnStyle : ColumnStyle
    , sorter : Sorter data
    , columnId : String
    }


stringColumn : String -> (data -> String) -> ColumnStyle -> Column data msg
stringColumn header data columnStyle =
    { header = header
    , viewData = \t -> Element.text (data t)
    , columnStyle = columnStyle
    , sorter = increasingOrDecreasingBy data
    , columnId = header
    }



-- VIEW


view : State -> (State -> msg) -> List data -> List (Column data msg) -> Element msg
view state toMsg rows columns =
    let
        sortedRows =
            sort state columns rows

        paginatedAndSortedRows =
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
    Element.indexedTable
        [ Element.centerX
        , Border.color (rgb255 55 55 55)
        , Border.widthEach { edges | bottom = 1 }
        , Border.solid
        ]
        { data = paginatedAndSortedRows
        , columns = List.map (\column -> customColumn state toMsg column) columns
        }


customColumn : State -> (State -> msg) -> Column data msg -> Element.IndexedColumn data msg
customColumn state toMsg column =
    { header = viewHeader state toMsg column
    , width = Element.fill
    , view = \idx t -> Element.el (defaultColumnStyle idx) (column.viewData t)
    }


viewHeader : State -> (State -> msg) -> Column data msg -> Element msg
viewHeader state toMsg column =
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
        [ Events.onClick (updateSort state toMsg column.columnId)
        , Border.color (rgb255 55 55 55)
        , Border.widthEach { edges | bottom = 1 }
        , Border.solid
        , Element.pointer
        ]
        [ Element.el
            [ Element.paddingXY 20 8
            , Font.bold
            ]
            (Element.text column.header)
        , Element.image [ Element.alignRight ]
            { src = sortUrl
            , description = ""
            }
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


pagingView : State -> (State -> msg) -> List data -> Element msg
pagingView state toMsg rows =
    case state.rowsPerPage of
        Exactly t ->
            pagingViewHelper state toMsg rows (List.length rows // t)

        All ->
            Element.none


pagingViewHelper : State -> (State -> msg) -> List data -> Int -> Element msg
pagingViewHelper state toMsg rows lastIndex =
    let
        totalRows =
            List.length rows

        pagingStateClick page =
            setPagingState state totalRows toMsg page

        activeOrNot pageIndex =
            let
                labelStyle =
                    if pageIndex == state.pageIndex then
                        [ Font.color (Element.rgb255 63 81 181)
                        , Background.color (Element.rgb255 230 230 230)
                        , Element.padding 2
                        , Border.solid
                        , Border.width 1
                        , Border.color (Element.rgb255 50 50 50)
                        ]

                    else
                        [ Font.color (Element.rgb 0 0 0) ]
            in
            Input.button []
                { onPress = Just (pagingStateClick (Index pageIndex))
                , label = Element.el labelStyle (Element.text (String.fromInt (pageIndex + 1)))
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
    Element.row
        [ Element.spacing 10
        , Element.padding 10
        , Background.color (Element.rgb255 240 240 240)
        , Element.width Element.fill
        ]
        [ Input.button []
            { onPress = firstPageClick
            , label = Element.text "First"
            }
        , Input.button []
            { onPress = leftPageClick
            , label = Element.text "Previous"
            }
        , Element.row [ Element.spacing 10 ] rng
        , Input.button []
            { onPress = rightPageClick
            , label = Element.text "Next"
            }
        , Input.button []
            { onPress = lastPageClick
            , label = Element.text "Last"
            }
        ]



-- Sorting


type Sorter data
    = None
    | IncOrDec (List data -> List data)


updateSort : State -> (State -> msg) -> String -> msg
updateSort state toMsg columnId =
    if state.sortField == columnId && state.sortAscending == False then
        toMsg { state | sortAscending = False, sortField = "" }

    else
        toMsg { state | sortAscending = not state.sortAscending, sortField = columnId }


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
                sortOp data

            else
                List.reverse (sortOp data)


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
