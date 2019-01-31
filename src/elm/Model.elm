module Model exposing (Device, Model, Msg(..), State(..))


type alias Model =
    { state : State }


type State
    = NotConnected
    | Scanning (List Device)
    | Connected Device


type alias Device =
    { name : String
    , address : String
    , rssi : String
    }


type Msg
    = NoOp
    | StartScan
    | Disconnect (Maybe String)
    | ScanSuccess Device
    | ScanFailure
    | ConnectTo String
    | ConnectSuccess
    | ConnectFailure
    | ServiceSuccess
    | ServiceFailure
    | SendData
    | SendDataSuccess
    | SendDataFailure
    | ReceivedData
