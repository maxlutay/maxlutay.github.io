port module Ports exposing (..)





port changereallocation: String -> Cmd msg
port back: () -> Cmd msg
port forward:() -> Cmd msg
port out: String ->Cmd msg