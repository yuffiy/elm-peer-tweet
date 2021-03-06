module Download.View.DownloadProgress where

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Action as RootAction exposing (..)
import Download.Model exposing (Model, downloadingItemsCount)

view : Signal.Address RootAction.Action -> Model -> Html
view address model =
  div [class "sidebar-status ion-ios-cloud-download down"] [
    downloadingItemsCount model
      |> toString
      |> text
  ]
