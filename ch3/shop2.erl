-module(shop2).
-export([total/1]).
-import(lists, [map/2, sum/1]).

total(L) ->
    sum(map(fun({What, N}) ->
		    cost(What) * N
	    end, L)).

cost(apple) ->
    5;
cost(orange) ->
    10;
cost(melon) ->
    3;
cost(_) ->
    0.



