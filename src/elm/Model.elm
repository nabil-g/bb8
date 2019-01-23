module Model exposing (Model,State(..),Device)


type alias Model =
    { state : State}

type State =
    NotConnected
    | Scanning (List Device)
    | Connected (Device)

type alias Device =
    { name : String
    , address : String
    , rssi : String
    }
