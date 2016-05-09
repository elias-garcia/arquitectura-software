%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #9: Cross Ring of Processes
%%% Created : 9 May 2016
%%%-------------------------------------------------------------------

-module(crossring).

-export([start/3]).

-define(CROSSRING, crossring).

%% @doc Starts the ring
%% @spec start(nat(), nat(), any()) -> ok
start(ProcNum, MsgNum, Message) when (ProcNum > 0), (MsgNum > 0) ->
    true = register(?CROSSRING, spawn(fun() -> init_master(ProcNum-1, MsgNum, Message) end)),
    ok.

init_master(0, MsgNum, Message) ->
    whereis(?CROSSRING) ! {MsgNum-1, Message, any},
    loop(whereis(?CROSSRING));
init_master(ProcNum, MsgNum, Message) ->
    Half = ProcNum div 2,
    Rest = ProcNum rem 2,
    case {Half > 0, Half+Rest > 0} of
        {true, true} ->
            Left = spawn(fun() -> init(Half-1) end),
            Right = spawn(fun() -> init(Half+Rest-1) end),

            Left ! {MsgNum-1, Message, left},
            loop_master(Left, Right);
        {false, true} ->
            Right = spawn(fun() -> init(Half+Rest-1) end),
            Right ! {MsgNum-1, Message, any},
            loop(Right)
    end.

init(0) ->
    loop(whereis(?CROSSRING));
init(ProcNum) ->
    Next = spawn(fun() -> init(ProcNum-1) end),
    loop(Next).

loop_master(Left, Right) ->
    receive
        {0, _Message, _From} ->
            Left ! stop,
            Right ! stop,
            unregister(?CROSSRING),
            ok;
        {MsgNum, Message, right} ->
            Left ! {MsgNum-1, Message, left},
            loop_master(Left, Right);
        {MsgNum, Message, left} ->
            Right ! {MsgNum-1, Message, right},
            loop_master(Left, Right);
        stop ->
            Left ! stop,
            Right ! stop,
            unregister(?CROSSRING),
            ok;
        _Other ->
            loop_master(Left, Right)
    end.

loop(Next) ->
    receive
        {0, _Message, _From} ->
            Next ! stop,
            ok;
        {MsgNum, Message, From} ->
            Next ! {MsgNum-1, Message, From},
            loop(Next);
        stop ->
            catch Next ! stop,
            ok;
        _Other ->
            loop(Next)
    end.
