%%% Getting Started With gen_server.
%%% There are 3-point plan for writing a gen_server
%%% callback module:
%%% 1. Decide on a callback module name.
%%% 2. Write the interface functions.
%%% 3. Write the six required callback functions in the callback module.

-module(my_bank).

%% export callback routines.
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start/0, stop/0, new_account/1, deposit/2, withdraw/2, transfer/3]).

-behaviour(gen_server).
-import(gen_server, [call/2]).


% Open the Bank.
start() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [],[]).

% Close the Bank.
stop() ->
    call(?MODULE, stop).

% Create a new account.
new_account(Who) ->
    call(?MODULE, {new, Who}).

% Put money in the bank.
deposit(Who, Amount) ->
    call(?MODULE, {add, Who, Amount}).

% Take money out, if in credit.
withdraw(Who, Amount) ->
    call(?MODULE, {remove, Who, Amount}).

% Transfer money from x to y;
transfer(Who, Whom, Amount) ->
    call(?MODULE, {transfer, Who, Whom, Amount}).

%% CALLBACK ROUTINES
init([]) ->
    {ok, ets:new(?MODULE, [])}.


handle_call({new, Who}, _From, Tab) ->
    Reply = case ets:lookup(Tab, Who) of
		[] ->
		    ets:insert(Tab, {Who, 0}),
		    {welcome, Who};
		[_] ->
		    {Who, you_already_are_a_customer}
	    end,
    {reply, Reply, Tab};
handle_call({add, Who, X}, _From, Tab) ->
    Reply = case ets:lookup(Tab, Who) of
		[] ->
		    not_a_customer;
		[{Who, Balance}] ->
		    NewBalance = Balance + X,
		    ets:insert(Tab, {Who, NewBalance}),
		    {thanks, Who, your_balance_is, NewBalance}
	    end,
    {reply, Reply, Tab};
handle_call({remove, Who, X}, _From, Tab) ->
    Reply = case ets:lookup(Tab, Who) of
		[] ->
		    not_a_customer;
		[{Who, Balance}] when Balance >= X ->
		    NewBalance = Balance - X,
		    ets:insert(Tab, {Who, NewBalance}),
		    {thanks, Who, your_new_balance_is, NewBalance};
		[{Who, Balance}] ->
		    {sorry, Who, you_only_have, Balance, in_the_bank}
	    end,
    {reply, Reply, Tab};
handle_call({transfer, _Who, _Whom, _Amount}, _From, Tab) ->
    {reply, ok, Tab};
handle_call(stop, _From, Tab) ->
    {stop, normal, stopped, Tab}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


