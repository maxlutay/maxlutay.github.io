module Main exposing (..)


import Date exposing (Date)
import Html exposing (Html, Attribute, div,  text, h1,a)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

main : Program  Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }




type alias Model = {
     route    : Route
    ,auth     : Maybe Loginfo
    ,posts    : List Post
    ,examples : List Example
    ,history  : List Route 
}





type Route =  Index
            | Menu
            | Contacts
            | About
            | Portfolio
            | Blog
            | Unknown
-- todo: add admin panel


type alias Loginfo = {
     token: Maybe String
    ,login: String
    ,password: String
}


type alias Post = {
     hash : String
    ,date : Date
    ,content : Html Msg
-- todo: replace string with Html Msg
}

type alias Example = {
     hash: String
    ,url : String
    ,date: Date
}






type Msg = NoOp | Back | Go Route






--init
init:  (Model, Cmd Msg)
init = 
    (Model  Index Maybe.Nothing [] [] [Index], Cmd.none)




view : Model -> Html Msg
view model =
    let 
        location = "{" ++ getlocation model.route
        
    in
        div [class "main"]
            [ 
                h1 [] [text location]
                ,h1 [] [text <| toString model.history]
                
                ,ahome
                ,back model

                ,index <| if model.route == Index then "focus" else  "blur"
                ,menu <| if model.route == Menu then "focus" else  "blur"
                ,xz
                ,err "404" ""
            ]






menu : String -> Html Msg
menu cl = --class
     div [class <|"view_menu " ++ cl ]
            [    a [onClick (Go Contacts)   ] [text "contacts"  ]    
                ,a [onClick (Go About)      ] [text "about"     ]
                ,a [onClick (Go Portfolio)  ] [text "portfolio" ]
                ,a [onClick (Go Blog)       ] [text "blog"      ]
            ]



index:String -> Html Msg
index cl= div [class <| "view_index "++ cl ]
              [  
                  a [onClick (Go Menu) ] [text "menu"]
              ]



err: String -> String -> Html Msg 
err what cl = div [class <|"view_404" ++ cl][h1 [] [text what] , ahome]


ahome: Html Msg
ahome =  
    a [onClick (Go Index)] [text "btn_home"]


--just for test

xz: Html Msg
xz = 
    a [class "btn_xz",onClick (Go Unknown)] [text "go 404"]
--



back: Model -> Html Msg
back model = 
    a [class "btn_back" ,onClick Back ] [text "BACK"]



getlocation: Route -> String
getlocation r =
    case r of
        Index    -> "/home"
        Menu     -> "/menu"
        Contacts -> "/contacts"
        About    -> "/about"
        Portfolio-> "/portfolio"
        Blog     -> "/blog/list"
        Unknown  -> "/error404"
        




update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let 
        backhist = if List.length model.history > 2 
                   then Maybe.withDefault [Index] <|List.tail model.history
                   else  [Index]
                   -- in case of single element in array
                   -- 'List.tail' fn give empty list
    in
  case msg of
    NoOp ->( model, Cmd.none )
    Back -> ( { model |
                   history = backhist
                  ,route = Maybe.withDefault Index <|List.head backhist
               }
               , Cmd.none)
    Go dest ->  if dest == model.route
                then (model, Cmd.none) 
                else ( { model | 
                             route=dest
                            ,history = dest :: model.history
                        }
                        , Cmd.none)
 
