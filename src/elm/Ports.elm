port module Ports exposing (disconnect, startScan, subscriptions)

import Model exposing (Device, Model, Msg(..))



-- OUTGOING


port startScan : () -> Cmd msg


port disconnect : Maybe String -> Cmd msg


port sendData : String -> Cmd msg



-- INCOMING


port scanSuccess : (Device -> msg) -> Sub msg


port scanFailure : (() -> msg) -> Sub msg


port connectSuccess : (Device -> msg) -> Sub msg


port connectFailure : (Int -> msg) -> Sub msg


port serviceSuccess : (Device -> msg) -> Sub msg


port serviceFailure : (Int -> msg) -> Sub msg


port sendDataSuccess : (() -> msg) -> Sub msg


port sendDataFailure : (Int -> msg) -> Sub msg


port receivedData : (() -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions m =
    Sub.batch [ scanSuccess ScanSuccess ]
