module Main exposing (main)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Model exposing (Model, Msg(..), State(..))
import Ports exposing (subscriptions)
import Update exposing (update)
import Url exposing (Url)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.document { init = init, view = view, update = update, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { state = NotConnected }
    , Cmd.none
    )



{- devices =
   [ { name = "Avion"
     , address = "Gateau"
     , rssi = "dsdsdsd"
     }
   , { name = "Avion"
     , address = "Gateau"
     , rssi = "dsdsdsd"
     }
   , { name = "Avion"
     , address = "Gateau"
     , rssi = "dsdsdsd"
     }
   , { name = "Avion"
     , address = "Gateau"
     , rssi = "dsdsdsd"
     }
   ]
-}
