-module(prime_server).
-behaviour(gen_server).

-export([start_link/0, new_prime/1]).

%% gen_server callbacks.
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


new_prime(K) ->
    gen_server:call(?MODULE, {prime, K}).

init([]) ->
    process_flag(trap_exit, true),
    io:format("### ~p Starting~n", [?MODULE]),
    {ok, 0}.

handle_call({prime, K}, _From, N) ->
    {reply, make_prime(K), N+1}.

handle_cast(_Msg, N) ->
    {noreply, N}.

handle_info(_Info, N) ->
    {noreply, N}.

terminate(_Reason, _N) ->
    io:format("### ~p Stopping~n", [?MODULE]),
    ok.

%% _O -> _OldVsn
%%  N -> State
%% _E -> _Extra
code_change(_O, N, _E) ->
    {ok, N}.

make_prime(K) ->
    if 
	K > 50 ->
	    alarm_handler:set_alarm(tooHot),
	    N = rand:uniform(K),
	    alarm_handler:clear_alarm(tooHot),
	    N;
	true ->
	    rand:uniform(K)
    end.
