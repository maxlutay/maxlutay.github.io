module Update exposing (update)





import  Types exposing (Model, Msg(..), History)


import Array
import Navigation as N
import Routing as R



update: Msg -> Model -> (Model, Cmd Msg)
update msg m  = let log = Debug.log "up" <| (toString msg) ++ " * " ++  toString m in
    case msg of
        NoOp        -> (m,Cmd.none)
        Back i      -> let
                            at = if m.index > 1
                                 then m.index - 1 
                                 else 1     
                       in ({m| index = at}, N.back 1)
        Forward i   -> let 
                            at = if m.index < m.maxi
                                 then m.index + 1
                                 else m.maxi                        
                        in ({m | index = at}, N.forward 1)
        Go route    -> ({m | 
                              current = route
                            , index = m.index + 1
                            , maxi = m.index + 1
                        }
                        , N.newUrl <| String.toLower 
                                   <| toString route
                        )
        Url route   -> ({m | current = route}, Cmd.none)