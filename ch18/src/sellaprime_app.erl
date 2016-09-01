-module(sellaprime_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    Result = sellaprime_sup:start_link([]),
    io:format("~p~n", [Result]),
    Result.

stop(_State) ->
    ok.
    
