module Types exposing (..)


import Array exposing (Array)

type Route =  Index
            | Unknown
            | Menu
            | Contacts
            | About
            | Portfolio
            | Example String
            | Blog
            | Post String


type Msg = NoOp
         | Go Route
         | Url Route
         | Back Int
         | Forward Int




type alias Model = {
    posts: List PostData
    ,examples: List ExampleData
    ,current: Route
    ,index: Int
    ,maxi: Int
}

type alias History = {
     at: Int
    ,arr: Array Route
}


type alias PostData = {
    heading: String
    ,datetime: String
    ,content: String
    ,url: String
}


type alias ExampleData = {
    datetime: String
    ,linkedto: String
    ,url: String
}







