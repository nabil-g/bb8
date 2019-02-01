module Update exposing (update)

import Model exposing (Device, Model, Msg(..), State(..))
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StartScan ->
            ( { model | state = Scanning [] }, Ports.startScan () )

        Disconnect errorString ->
            ( { model | state = NotConnected }, Ports.disconnect errorString )

        ScanSuccess device ->
            let
                newList =
                    case model.state of
                        Scanning list ->
                            device :: list

                        _ ->
                            List.singleton device
            in
            ( { model | state = Scanning newList }, Cmd.none )

        ScanFailure errorMsg ->
            update (Disconnect errorMsg) model

        ConnectTo address ->
            ( model, Ports.connectTo address )

        ConnectFailure errorMsg ->
            update (Disconnect errorMsg) model

        ServiceSuccess device ->
            ( { model | state = Connected device }, Cmd.none )

        ServiceFailure errorMsg ->
            update (Disconnect errorMsg) model

        SendData data ->
            ( model, Ports.sendData data )

        SendDataFailure errorMsg ->
            update (Disconnect errorMsg) model

        ReceivedData _ ->
            ( model, Cmd.none )
