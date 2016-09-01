-module(area_server_final).
-export([start/0, area/2]).

start() ->
    spawn(fun loop/0).

area(Pid, What) ->
    rpc(Pid, What).

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
