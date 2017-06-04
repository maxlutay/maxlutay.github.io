module Main exposing (..)


import Date exposing (Date)
import Html exposing (Html, Attribute, div,  text, h1,h5,a)
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
--          | Blog Post
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

        buttons = if model.route == Index 
                  then [   alink (Go Menu)  "btn_menu" "MENU[icon]"
                       ]
                  else [   alink (Go Index) "btn_home" "CLOSE/HOME[icon]"
                         , alink  Back      "btn_back" "[icon]BACK"
                       ]
        
    in
        div [class "main"]
            <| List.append buttons 
            [ 
                 --h1 [] [text location]
                --,h1 [] [text <| toString model.history]
                

                index <| if model.route == Index 
                          then "view_focus" 
                          else  "view_blur"
                ,menu <| if model.route == Menu 
                         then "view_focus" 
                         else  "view_blur"
                --,xz
                ,err "404" <| if model.route /= Index && model.route /=Menu
                              then "view_focus"
                              else  "view_blur"
            ]



alink: Msg -> String -> String -> Html Msg
alink m c t =
    a [onClick m, class <| "btn " ++ c] [text t]


menu : String -> Html Msg
menu cl = --class
     div [class <|"view view_menu " ++ cl ]
            [    alink (Go Contacts)  "" "contacts"    
                ,alink (Go About)     "" "about"
                ,alink (Go Portfolio) "" "portfolio"
                ,alink (Go Blog)      "" "blog"
            ]



index:String -> Html Msg
index cl= div [class <| "view view_index "++ cl ]
              [  
                    h1 [] [text "Max Lutay"]
                  , h5 [] [text "front-end hero"]
              ]



err: String -> String -> Html Msg 
err what cl = div [class <|"view view_404 " ++ cl][h1 [] [text what] ]



---{just for test

xz: Html Msg
xz = 
    alink (Go Unknown) "btn_xz" "go 404"
--}-






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
                   -- 'List.tail' fn gives empty list []
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
 
