module HistoryUtils exposing (..)



import Types exposing (..)
import Array exposing (Array)



geturl: Route -> String
geturl r =
    case r of
        Index        -> "/"
        Menu         -> "/menu"
        Contacts     -> "/contacts"
        About        -> "/about"
        Portfolio    -> "/portfolio"
        Blog Nothing -> "/blog"
        Blog (Just p)-> "/blog/" ++ p.heading ++ "/" ++ toString p.date
        _  -> "/404"
        

getlocation: Route -> Location
getlocation r = (r, geturl r)



getlocationathistory: Int -> Array Location ->  Location
getlocationathistory i h = Maybe.withDefault (getlocation Unknown)
                           <| Array.get i h





backat: Model -> Maybe Int
backat model = if model.at > 0 then Just <|model.at - 1 else Nothing


forwardat: Model -> Maybe Int
forwardat model = let
                        len = Array.length model.history
                  in
                  if (len - 1) > model.at
                  then Just <|model.at + 1
                  else Nothing

