module Routing exposing (..)



import Navigation exposing (Location)

import Types exposing (Route(..))


import UrlParser as U exposing ( (</>) )







locationparser: U.Parser (Route -> a) a
locationparser =
    U.oneOf 
        [
             U.map Index U.top
            ,U.map Index (U.s "index.html")
            ,U.map Index (U.s "index")
            ,U.map Unknown (U.s "404")
            ,U.map Unknown (U.s "unknown")
            ,U.map Menu (U.s "menu")
            ,U.map Contacts (U.s "contacts")
            ,U.map About (U.s "about")
            ,U.map Post (U.s "blog/post" </> U.string)
            ,U.map Blog (U.s "blog")
            ,U.map Example (U.s "portfolio" </> U.string)
            ,U.map Portfolio (U.s "portfolio")
        ]





getRouteFromLocation: Location -> Route
getRouteFromLocation l =let log = Debug.log "gRfL" <| toString l in
    case (U.parsePath locationparser l) of
        Just r  -> r
        _ -> Unknown  






getPathFromRoute: Route -> String
getPathFromRoute r = 
    case r of
        Post p  -> "blog/post/" ++ p
        Example _ -> "portfolio/example/" 
        a -> String.toLower <| toString r





