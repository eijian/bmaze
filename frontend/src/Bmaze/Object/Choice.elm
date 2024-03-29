-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Bmaze.Object.Choice exposing (..)

import Bmaze.InputObject
import Bmaze.Interface
import Bmaze.Object
import Bmaze.Scalar
import Bmaze.ScalarCodecs
import Bmaze.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


sceneno : SelectionSet Int Bmaze.Object.Choice
sceneno =
    Object.selectionForField "Int" "sceneno" [] Decode.int


text : SelectionSet String Bmaze.Object.Choice
text =
    Object.selectionForField "String" "text" [] Decode.string
