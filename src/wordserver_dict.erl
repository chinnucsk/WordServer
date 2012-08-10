%%%-------------------------------------------------------------------
%%% @author Arjen Wiersma <>
%%% @copyright (C) 2012, Arjen Wiersma
%%% @doc
%%%
%%% @end
%%% Created :  8 Aug 2012 by Arjen Wiersma <>
%%%-------------------------------------------------------------------
-module(wordserver_dict).

-behaviour(gen_server).

%% API
-export([start_link/0, walk/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

walk() ->
    gen_server:call(?MODULE, {walk}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
init([]) ->
    ets:new(words, [named_table,duplicate_bag]),
    ets:insert(words, {"A", 1, 0, 0}),
    ets:insert(words, {"R", 2, 1, 0}),
    ets:insert(words, {"J", 3, 2, 0}),
    ets:insert(words, {"E", 4, 3, 0}),
    ets:insert(words, {"N", 5, 4, 1}),
    ets:insert(words, {"A", 6, 3, 0}),
    ets:insert(words, {"N", 7, 6, 1}),
    {ok, #state{}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @spec handle_call(Request, From, State) ->
%%                                   {reply, Reply, State} |
%%                                   {reply, Reply, State, Timeout} |
%%                                   {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, Reply, State} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_call({walk}, _From, State) ->
    %% Find the ones with no predecessor
    walk_words(lists:map(fun(X) 
                            -> {Letter, Index, From, EndOfWord} = X, 
                               {Letter,Index,From,EndOfWord, ""} 
                         end, ets:match_object(words, {'_','_', 0, 0}))),
    {reply, ok, State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

walk_words([{Letter, Index, _From, 0, WordSoFar}|T]) ->
%%    io:format("[~p ~p]~n",[Index, WordSoFar]),
    walk_words(lists:map(fun(X) 
                 -> {NewLetter, NewIndex, NewFrom, NewEndOfWord} = X, 
                    {NewLetter, NewIndex, NewFrom, NewEndOfWord, WordSoFar ++ Letter} 
              end, ets:match_object(words, {'_','_', Index, '_'})) ++ T);
walk_words([{Letter, _Index, _From, 1, WordSoFar}|T]) ->
    io:format("~s~n",[WordSoFar ++ Letter]),
    walk_words(T);
walk_words([]) ->
    io:format("End of dictionary~n").

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @spec handle_cast(Msg, State) -> {noreply, State} |
%%                                  {noreply, State, Timeout} |
%%                                  {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_cast(_Msg, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_info(_Info, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
