-module(shop).
-export([cost/1]).


cost(apple) -> 5;
cost(orange) ->  4;
cost(melon) -> 12;
cost(_) -> 0.
    
