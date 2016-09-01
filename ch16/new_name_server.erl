-module(new_name_server).
-export([init/0, add/2, whereis/1, all_names/0, handle/2]).
-import(server3, [rpc/2]).

%% client routines.
add(Name, Place) ->
    rpc(?MODULE, {add, Name, Place}).
whereis(Name) ->
    rpc(?MODULE, {whereis, Name}).
all_names() ->
    rpc(?MODULE, allNames).

%% callback routines.
init() ->
    dict:new().

handle({add, Name, Place}, Dict) ->
    {ok, dict:store(Name, Place, Dict)};
handle({whereis, Name}, Dict) ->
    {dict:find(Name, Dict), Dict};
handle(allNames, Dict) ->
    {dict:fetch_keys(Dict), Dict}.

