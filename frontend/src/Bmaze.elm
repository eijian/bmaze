--- Bmaze 
---

module Bmaze exposing (..)

import Browser

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (..)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns as Columns exposing (..)
import Bulma.Layout exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
---
import Bmaze.Query as Query
import Bmaze.Object exposing (..)
import Bmaze.Object.Book as Book
import Bmaze.Object.Scene as Scene


type alias Model =
  { code : String
  , title : String
  , scene : Int
  }

type Msg =
    Click
  | List Maybe String
  | Book String
  | Scene String Int

---

main : Program () Model Msg
main =
  Browser.sandbox
  { init = init
  , view = view
  , update = update
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( { code = ""
    , title = ""
    , scene = 0
    }
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
  List btitle ->
    ( { model
        | code = ""
        , title = btitle
      }
    , Cmd.none -- queryBooks model.title
    )
  Book bcode ->
    ( { model
        | code = bcode
        , scene = 0
      }
    , Cmd.none -- getBookInfo model.code
    )
  Scene bcode bscene ->
    ( { model
        | code = bcode
        , scene = bscene
      }
    , Cmd.none --getScene model.code model.scene
    )

--- Books

{-
type alias ResponseBooks =
  { vader : Maybe [BooksData]
  }

type alias BooksData =
  { code : String
  , title : String
  , author : Maybe String
  , date : Maybe String
  , lead : Maybe String
  }

getBooks : String -> Cmd Msg
getBooks title =

queryBooks : String -> SelectionSet ResponseBooks RootQuery
queryBooks Noting =
  SelectionSet.map ResponseBooks
    (Query.books booksSelection)
queryBooks (Just t) =
  SelectionSet.map ResponseBooks
    (Query.books { title = t} booksSelection)

-}

-- VIEW

view : Model -> Html Msg
view model =
  main_ []
  [ styleshet
  , fontAwesomeCDN
  , div [ class Bulma.container ]
        [ header model
        , body model
        , footer
        ]
  ]

fontAwesomeCDN =
  Html.node "link"
  [ rel "stylesheet"
  , href "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
  ]
  []




