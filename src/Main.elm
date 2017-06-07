--KEEP IT SIMPLE, DUDE!

module Main exposing (..)

import Html exposing (Html)
import Types exposing (..)
import Ports exposing (..)
import View exposing (..)
import Array
import HistoryUtils exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }







--init
init:  (Model, Cmd Msg)
init = 
    (Model  
        0
        Nothing
        []
        []
        (Array.push (getlocation Index) Array.empty)
    , Cmd.none)








update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        from = getlocationathistory model.at model.history
        index = model.at
        prevhistory = Debug.log "hist: ~" model.history 
    in    
    case msg of
        Go to -> if  from /= to 
                 then  ({model | 
                             history = Array.push to 
                                     <| Array.slice 0 (index + 1) model.history
                              ,at = model.at + 1
                         }
                         , changereallocation <| Tuple.second to )
                 else (model, Cmd.none)
        Back -> let 

                    newat = Maybe.withDefault 0 <|backat model
                    tourl = Tuple.second  <| getlocationathistory newat model.history
                in 
                ({model|
                    at = newat                
                 },changereallocation tourl)
        Forward -> let
                        newat = Maybe.withDefault (Array.length model.history - 1) <|forwardat model
                        tourl = Tuple.second  <| getlocationathistory newat model.history
                   in
                    ({model|
                        at = newat
                    }, changereallocation tourl)
        _ ->( model, Cmd.none )