module View exposing (..)


import Html exposing (Html, Attribute, div,  text, h1,h5,a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)

import Types exposing(..)

import HistoryUtils exposing (..)

view : Model -> Html Msg
view model =
            getpage model <| (Tuple.first <| getlocationathistory model.at model.history)



vref: Msg -> String -> String -> Html Msg
vref m c t = -- m is onclickmessage, c is appendclassname, t is innertext 
     a [   onClick m
         ,class <| "btn " ++ c
      ] [ text t ]


getpage:Model -> Route -> Html Msg
getpage md r = 
    let 
        mainclass = "main main_" ++ 
            case r of
                Index    -> "index"
                Menu     -> "menu"
                Contacts -> "contacts" 
                _ -> "404" 

        views = div [class "views"][ index "" , unknown "", menu "", contacts "" ]
        controlbuttons = div [class "control-buttons"] 
                             [ backbutton (if backat md /= Nothing
                                           then "button_on" 
                                           else "button_off")
                               , homebutton 
                               , forwardbutton (if forwardat md /= Nothing 
                                                then "button_on" 
                                                else "button_off")
                             ]
    in
    div [class mainclass][controlbuttons, views]
            





homebutton: Html Msg
homebutton =
    vref (Go (getlocation Index)) "button button_home button_control " "HOME"

backbutton:String -> Html Msg
backbutton cl = 
    vref Back ("button button_back button_control " ++ cl) "BACK"

forwardbutton:String -> Html Msg
forwardbutton cl =
    vref Forward ("button button_control " ++ cl) "FORWARD"

index:String -> Html Msg
index cl = 
        div [class <| "view view_index " ++ cl][
            h1 [class "view__h1"][text "Max Lutay"]
            ,vref (Go (getlocation Menu)) "link view__rtcornerlink" "/menu" 
        ]



unknown:String -> Html Msg
unknown cl = 
    div [class <| "view view_404 " ++ cl][
                h1 [] [text "404"]
                --,vref (Go (getlocation Index)) "link" "MAIN" 
            ]



menu: String -> Html Msg
menu cl =
    div [class <| "view view_menu "++ cl] 
        <| List.map (\loc -> vref (Go loc) "link" <| Tuple.second loc) [getlocation Contacts, getlocation About, getlocation Portfolio, getlocation <| Blog Nothing] 
    



contacts: String -> Html Msg
contacts cl = 
    div [class <| "view view_contacts "++ cl]
        [    div [] [text "email"]
            ,div [] [text "github"]
            ,div [] [text "twitter"]

        ]