port module Ports exposing (connectFailure, connectTo, disconnect, receivedData, scanFailure, scanSuccess, sendData, sendDataFailure, serviceFailure, serviceSuccess, startScan, subscriptions)

import Model exposing (Device, Model, Msg(..))



-- OUTGOING


port startScan : () -> Cmd msg


port disconnect : Maybe String -> Cmd msg


port sendData : String -> Cmd msg


port connectTo : String -> Cmd msg



-- INCOMING


port scanSuccess : (Device -> msg) -> Sub msg


port scanFailure : (Maybe String -> msg) -> Sub msg


port connectFailure : (Maybe String -> msg) -> Sub msg


port serviceSuccess : (Device -> msg) -> Sub msg


port serviceFailure : (Maybe String -> msg) -> Sub msg


port sendDataFailure : (Maybe String -> msg) -> Sub msg


port receivedData : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions m =
    Sub.batch
        [ scanSuccess ScanSuccess
        , scanFailure ScanFailure
        , connectFailure ConnectFailure
        , serviceFailure ServiceFailure
        , sendDataFailure SendDataFailure
        , receivedData ReceivedData
        ]
