-module(area_server0).
-export([loop/0]).

loop() ->
    receive
	{rectangle, X, Y} ->
	    io:format("Area of rectangle is ~p~n", [X * Y]),
	    loop();
	{circle, Y} ->
	    io:format("Area of circle is ~p~n", [Y * Y * 3.14]),
	    loop();
	Other ->
	    io:format("I don't know what the area of ~p~n", [Other]),
	    loop()
    end.
