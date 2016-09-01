-module(client).
-export([init/0, add/2, whereis/1, handle/2]).
-import(server3, [rpc/2]).

%% client routines.
add(Name, Place) ->
    rpc(?MODULE, {add, Name, Place}).
whereis(Name) ->
    rpc(?MODULE, {whereis, Name}).


%% callback routines.
init() ->
    dict:new().

handle({add, Name, Place}, Dict) ->
    {ok, dict:store(Name, Place, Dict)};
handle({whereis,Name}, Dict) ->
    {dict:find(Name, Dict), Dict}.
