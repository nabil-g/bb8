port module Ports exposing (disconnect, startScan)

import Model exposing (Device)



-- OUTGOING


port startScan : () -> Cmd msg


port disconnect : String -> Cmd msg


port sendData : String -> Cmd msg



-- INCOMING


port scanSuccess : (Device -> msg) -> Sub msg


port scanFailure : (Int -> msg) -> Sub msg


port connectSuccess : (Device -> msg) -> Sub msg


port connectFailure : (Int -> msg) -> Sub msg


port serviceSuccess : (Device -> msg) -> Sub msg


port serviceFailure : (Int -> msg) -> Sub msg


port sendDataSuccess : (() -> msg) -> Sub msg


port sendDataFailure : (Int -> msg) -> Sub msg


port receivedData : (() -> msg) -> Sub msg
