module Accounts.Ports (..) where

import Account.Model as Account
import Action exposing (..)
import Accounts.Action exposing (..)
import Ports exposing (jsMailbox)
import Utils.Utils exposing (isJust, filterEmpty)


port accountStream : Signal (Maybe Account.Model)
port requestAddTweet : Signal (Maybe AddTweetRequestPayload)
port requestAddTweet =
  let
    getRequest action =
      case action of
        ActionForAccounts (AddTweetRequest req) ->
          Just req

        _ ->
          Nothing
  in
    Signal.map getRequest jsMailbox.signal
      |> filterEmpty


port requestAddFollower : Signal (Maybe AddFollowerRequestPayload)
port requestAddFollower =
  let
    getRequest action =
      case action of
        ActionForAccounts (AddFollowerRequest req) ->
          Just req

        _ ->
          Nothing
  in
    Signal.map getRequest jsMailbox.signal
      |> filterEmpty


accountInput : Signal Action.Action
accountInput =
  Signal.map
    (Maybe.map (ActionForAccounts << UpdateUserAccount) >> Maybe.withDefault Action.NoOp)
    accountStream
