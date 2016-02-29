module Main (main) where

import View exposing (view)
import Data.Model as Data
import Model exposing (Model, initialModel)
import StartApp
import Html exposing (Html)
import Action exposing (..)
import Data.Action exposing (..)
import Update exposing (update)
import Task exposing (Task)
import Effects exposing (Never)
import Time exposing (every, second)

-- App starting

app : StartApp.App Model
app = StartApp.start
  { init = initialModel
  , update = update jsMailbox.address
  , view = view
  , inputs = [incommingData] }

main : Signal Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks

-- JS interop

jsMailbox : Signal.Mailbox Action.Action
jsMailbox = Signal.mailbox NoOp

port setData : Signal Data.Model

port requestAddTweet : Signal (Maybe AddTweetRequestData)
port requestAddTweet =
  let isTweetRequest action =
        case action of
          ActionForData (AddTweetRequest req) -> True
          _ -> False

      getRequest action =
        case action of
          ActionForData (AddTweetRequest req) -> Just req
          _ -> Nothing
  in
    jsMailbox.signal
      |> Signal.filter isTweetRequest NoOp
      |> Signal.map getRequest

incommingData : Signal Action.Action
incommingData =
  Signal.map (ActionForData << UpdateData) setData

port requestDataSync : Signal Data.Model
port requestDataSync =
  Signal.sampleOn (every <| 30 * second) app.model
    |> Signal.map .data
