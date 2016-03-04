module Main (main) where

import View exposing (view)
import Model exposing (Model, initialModel)
import Action exposing (Action)
import StartApp
import Html exposing (Html)
import Update exposing (update)
import Task exposing (Task)
import Effects exposing (Never)
import Ports exposing (jsMailbox)
import Data.Ports exposing (dataInput)
import Publish.Ports exposing (requestPublish, publishHeadInput, publishTweetInput)
import Download.Ports exposing (requestDownload, downloadHeadInput, downloadTweetInput)

-- App starting

inputs : List (Signal Action)
inputs =
  [ requestPublish
  , dataInput
  , publishHeadInput
  , publishTweetInput
  , requestDownload
  , downloadHeadInput
  , downloadTweetInput ]

app : StartApp.App Model
app = StartApp.start
  { init = initialModel
  , update = update jsMailbox.address
  , view = view
  , inputs = inputs }

main : Signal Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
