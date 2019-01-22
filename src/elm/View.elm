module View exposing (view)

import Browser exposing (Document)
import Element exposing (Element, FocusStyle, Length, focusStyle, none)
import Element.Font as Font
import Model exposing (Model)
import Update exposing (Msg(..))


view : Model -> Document Msg
view model =
    { title = "BB-8"
    , body = [ Element.layoutWith { options = [ focusStyle <| FocusStyle Nothing Nothing Nothing ] } [ Font.size 18 ] none ]
    }
