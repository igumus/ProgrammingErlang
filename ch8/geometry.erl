-module(geometry).

-compile(export_all).

area({rectangle, X, Y}) ->
    X * Y;
area({circle, X}) ->
    X * X * 3.14.
