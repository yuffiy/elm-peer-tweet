module Data.Model (..) where

import Account.Model as Account
import Maybe exposing (andThen)


type alias Model =
  { hash : Account.HeadHash
  , accounts : List Account.Model
  }


initialModel : Model
initialModel =
  { hash = ""
  , accounts = []
  }


findAccount : Model -> Maybe Account.HeadHash -> Maybe Account.Model
findAccount model hash =
  let
    find hash =
      List.filter (\a -> a.head.hash == hash) model.accounts
        |> List.head
  in
    hash `andThen` find
