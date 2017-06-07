module Types exposing (..)

import Date exposing (Date)
import Html exposing (Html)
import Array exposing (Array)

type alias Model = {
     at       : Int    --Int is for history index
    ,auth     : Maybe LoginInfo
    ,posts    : List Post
    ,examples : List Example
    ,history  : Array Location
}


type Route =   Index
             | Menu
             | Contacts
             | About
             | Portfolio
             | Unknown
             | Blog (Maybe Post)
-- todo: add admin panel
type alias Location = (Route, String)


type alias LoginInfo = {
     token: Maybe String
    ,login: String
    ,password: String
}


type alias Post = {
     heading : String
    ,date : Date
    ,content : Html Msg
-- todo: replace string with Html Msg
}

type alias Example = {
     hash: String
    ,url : String
    ,date: Date
}



type Msg =   NoOp --todo: remove NoOp message
           | Forward 
           | Back 
           | Go Location


