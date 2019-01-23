module Update exposing (Msg(..), subscriptions, update)

import Model exposing (Model)
import Ports


type Msg
    = NoOp
    | StartScan
    | Disconnect
    | ScanSuccess
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StartScan ->
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions m =
    Sub.none
