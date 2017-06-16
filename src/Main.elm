
--KEEP IT SIMPLE, DUDE!
module Main exposing (..)

import Types exposing (Model, Msg(..))

import View exposing (view)
import Update exposing (update)
import Init exposing (init)
import Navigation
import Routing as R


main : Program Never Model Msg
main =
    Navigation.program (Url << R.getRouteFromLocation )
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

