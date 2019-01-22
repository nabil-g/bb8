module Main exposing (main)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Model exposing (Model)
import Update exposing (Msg(..), subscriptions, update)
import Url exposing (Url)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.application { init = init, view = view, update = update, subscriptions = subscriptions, onUrlChange = always NoOp, onUrlRequest = always NoOp }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( 1
    , Cmd.none
    )
