-module(geometry).
-export([area/1]).

-define(PI, 3.14).

area({square, X}) ->
    X * X;
area({rectangle, X, Y}) ->
    X * Y;
area({circle, X}) ->
    ?PI * X * X.

