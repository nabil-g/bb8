module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input as Input
import Element.Keyed as Keyed
import Model exposing (Device, Model, Msg(..), State(..))


view : Model -> Document Msg
view model =
    { title = "BB-8"
    , body = [ Element.layoutWith { options = [ focusStyle <| FocusStyle Nothing Nothing Nothing ] } [ Font.size 18 ] <| viewMain model ]
    }


viewMain : Model -> Element Msg
viewMain { state } =
    let
        renderState =
            case state of
                NotConnected ->
                    Input.button [ width fill, Background.color greenColor, Font.color whiteColor, padding 10, Border.color greenColor, Border.width 2, Border.rounded 3 ]
                        { onPress = Just StartScan
                        , label = el [ centerX, Font.bold, Font.size 25 ] <| text "SCAN"
                        }

                Scanning devicesList ->
                    column [ width fill, spacing 15 ]
                        [ el [ centerX, Font.bold, Font.size 20 ] <| text "Scanning ..."
                        , Keyed.column [ width fill, spacing 10 ] <| List.map viewDevice devicesList
                        ]

                Connected device ->
                    none
    in
    el [ width fill, height fill, padding 10 ] renderState


viewDevice : Device -> ( String, Element Msg )
viewDevice device =
    ( device.name
    , column [ width fill, Border.color greenColor, Border.width 2, Border.rounded 3, padding 10, onClick <| ConnectTo device.address ]
        [ el [ Font.size 20 ] <| text device.name
        , el [ Font.size 13 ] <| text device.address
        , el [ Font.size 13 ] <| text device.rssi
        ]
    )


greenColor : Color
greenColor =
    rgb255 148 228 119


whiteColor : Color
whiteColor =
    rgb255 255 255 255
