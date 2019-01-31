module Update exposing (update)

import Model exposing (Device, Model, Msg(..), State(..))
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StartScan ->
            ( { model | state = NotConnected }, Ports.startScan () )

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

        ScanFailure ->
            update (Disconnect <| Just "Failed to scan for devices.") model

        _ ->
            ( model, Cmd.none )
