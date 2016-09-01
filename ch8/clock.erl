-module(clock).
-export([start/2, stop/0]).

start(Time, Fun) ->
    register(clock, spawn(fun() ->
				  tick(Time, Fun) end)).

stop() ->
    clock ! stop.

tick(T, F) ->
    receive
	stop ->
	    void
    after T ->
	    F(),
	    tick(T, F)
    end.
