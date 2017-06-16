module Init exposing (..)

import Types exposing (Model, Route(..), Msg(..), History)



import Navigation exposing (Location)
import Array 

import Routing as R


--todo: data retriever module


init: Location -> (Model, Cmd Msg)
init l = (Model 
                [] 
                [] 
                (R.getRouteFromLocation l)
                1
                1
          , Cmd.none)



