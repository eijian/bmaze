-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Bmaze.ScalarCodecs exposing (..)

import Bmaze.Scalar exposing (defaultCodecs)
import Json.Decode as Decode exposing (Decoder)


type alias Id =
    Bmaze.Scalar.Id


codecs : Bmaze.Scalar.Codecs Id
codecs =
    Bmaze.Scalar.defineCodecs
        { codecId = defaultCodecs.codecId
        }