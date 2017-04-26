module Head exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode exposing (string)



type Maybe a = Just a | Nothing



model:Maybe a
model = Nothing

fn :  String
fn = """
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    """              






--uncomment if needed -- import Html.App as App

main : Program Never (Maybe a) msg
main =
  program
    { init = (model, Cmd.none)
    , view = \n-> div [ property "script" <| Json.Encode.string <| "this.parentNode.innerHTML = '" ++ fn ++ "';" ][]
    , update = \n -> \m-> (model,Cmd.none)
    , subscriptions = \ a ->Sub.none
    }

  