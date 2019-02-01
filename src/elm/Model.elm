module Model exposing (Device, Model, Msg(..), State(..))


type alias Model =
    { state : State }


type State
    = NotConnected
    | Scanning (List Device)
    | Connected Device


type alias Device =
    { name : String
    , address : Address
    , rssi : String
    }


type alias Address =
    String


type Msg
    = NoOp
    | StartScan
    | Disconnect (Maybe String)
    | ScanSuccess Device
    | ScanFailure (Maybe String)
    | ConnectTo Address
    | ConnectFailure (Maybe String)
    | ServiceSuccess Device
    | ServiceFailure (Maybe String)
    | SendData String
    | SendDataFailure (Maybe String)
    | ReceivedData String
