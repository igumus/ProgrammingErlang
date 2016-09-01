-module(area_server1).
-export([loop/0, rpc/2]).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
	{reply, Response} ->
	    Response;
	Other ->
	    Other
    end.

loop() ->
    receive
	{From, {rectangle, X, Y}} ->
	    From ! {reply, (X * Y)},
	    loop();
	{From, {circle, X}} ->
	    From ! {reply, (X * X * 3.14)},
	    loop();
	{From, Other} ->
	    From ! {error, Other},
	    loop()
    end.
