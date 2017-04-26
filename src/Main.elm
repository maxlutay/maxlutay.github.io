module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)





--Model

type alias Model =
    String


init : (Model, Cmd Msg)
init =
    ("beahc", Cmd.none)



--Messages

type Msg = 
    NoOp


--View

view : Model -> Html Msg
view model = 
         div []
              [
                  div [ style[("width","100px"),
                              ("height","25px"),
                              ("background","red")
                              ]
                      ]
                      [ text "I am red" 
                      ]
                ]
                 





--Update


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none






--main


main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
