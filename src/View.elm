module View exposing (..)

import Types exposing (Model, Msg(..), Route (..))

import Array

import Html exposing (Html, div, text, h1, h2, a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)

view : Model -> Html Msg
view m = 
    let 
        route = m.current
    in
        getPage route m 




getPage: Route -> Model -> Html Msg
getPage r m = let
                mainclass = 
                    case r of
                        Index   -> "index"
                        Menu    -> "menu"
                        Contacts-> "contacts"
                        --About   -> "about"
                        --Portfolio -> "portfolio"
                        --Blog    -> "blog" 
                        _       -> "404"
                vs = div [class "views"] views
                controlbuttons = div [class "control-buttons"][
                     backbutton <| "button_" ++ onoff m backavailable
                    ,homebutton <| "button_" ++ onoff m homeavailable
                    ,forwardbutton <| "button_" ++ onoff m forwardavailable 
                    
                ]
    in
        div [class <| "main main_"++ mainclass]
            [ controlbuttons, vs ]
            




onoff: Model -> (Model -> Bool) -> String
onoff m fn = if fn m then "on" else "off"

backavailable: Model -> Bool
backavailable m = m.index > 1 

forwardavailable: Model -> Bool
forwardavailable m = m.index < m.maxi


homeavailable: Model -> Bool
homeavailable m = m.current /= Index


views: List (Html Msg)
views =[            
         index
         ,menu
         ,contacts
         --,about
         --,portfolio
         --,blog
         ,unknown
        ]
        


vref: Msg -> String -> String -> Html Msg 
vref m cl txt =
    div [class <|"link "++ cl, onClick m] [text txt]





index: Html Msg
index = div [class "view view_index "][ 
                h1  [class "view__h1"]
                    [ text "Max Lutay",
                      vref (Go Menu) "view__rtcornerlink" "/menu"                   
                     ]
               ]

menu: Html Msg
menu = 
    div [class "view view_menu "]
    [   vref  (Go Contacts) "" "/contacts"
        ,vref (Go About) "" "/about"
        ,vref (Go Portfolio)  "" "/portfolio"
        ,vref (Go Blog) "" "/blog"    
    ]

contacts: Html Msg
contacts = div [class <| "view view_contacts "] [
                        a [href "mailto:maksym.lutai@gmail.com"][ text "email"]
                        ,a [href "http://github.com/maxlutay"][ text "github"]
                        --,a [href "http://vk.com/max_lutay"][ text "vk"]
                        ,a [href "http://twitter.com/max_lutay"][ text "twitter"]
                    ]







homebutton:String -> Html Msg
homebutton cl=
    vref (Go Index) ("button button_home button_control "++ cl) "HOME"

backbutton:String -> Html Msg
backbutton cl = 
    vref (Back 1) ("button button_back button_control " ++ cl) "BACK"

forwardbutton:String -> Html Msg
forwardbutton cl =
    vref (Forward 1) ("button button_forward button_control " ++ cl) "FORWARD"



unknown: Html Msg
unknown = 
    div [class "view view_404 "]
        [
                h1 [] [text "404"]
         ]








