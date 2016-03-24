module Timeline.View.Tweet (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Account.Model exposing (Head, Tweet)
import Time exposing (Time)
import DateTime.View.TimeDifference exposing (formatTimeDifference)


view : Time -> { head: Head, tweet: Tweet } -> Html
view timestamp { head, tweet } =
  li
    [ class "collection-item tweet" ]
    [ i [ class "material-icons circle red avatar" ] [ text "play_arrow" ]
    , div
        [ class "tweet-info" ]
        [ span [ class "title" ] [ text head.n ]
        , span
            [ class "secondary-content" ]
            [ text <| formatTimeDifference timestamp <| toFloat tweet.d
            ]
        , p
            []
            [ text tweet.t
            ]
        ]
    ]
