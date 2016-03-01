module Sync.Signals where

import Action as RootAction exposing (..)
import Sync.Action exposing (..)
import Time exposing (every, second)

requestPublish : Signal RootAction.Action
requestPublish =
  (every <| 30 * second)
    |> Signal.map (\_ -> ActionForSync BeginSync)
