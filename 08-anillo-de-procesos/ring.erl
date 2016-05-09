%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #8: Process Ring
%%% Created : 19 Apr 2016
%%%-------------------------------------------------------------------

-module(ring).

-export([start/3, init/3, loop/1]).

%% @doc Creates the main process of the ring.
%% @spec start(ProcNum::integer(), MsgNum::integer(), Message::string()) -> ok
start(ProcNum, MsgNum, Message) ->
    Master = spawn(ring, init, [ProcNum, MsgNum, Message]),
    register(master, Master),
    ok.

%% @doc Creates processes of the ring and keep them waiting for messages.
%% @spec init(ProcNum::integer(), MsgNum::integer(), Message::string())->
init(1, MsgNum, Message) ->
    Master = whereis(master),
    Master ! {MsgNum-1, Message},
    loop(Master);
init(ProcNum, MsgNum, Message) ->
    Slave = spawn(ring, init, [ProcNum-1, MsgNum, Message]),
    loop(Slave).

%% @doc Keeps every process waiting for messages.
%% @spec
loop(Pid) ->
    receive
        {0, _Message} ->
            Pid ! stop,
            unregister(master);
        {MsgNum, Message} ->
            Pid ! {MsgNum-1, Message},
            loop(Pid);
        stop ->
            Pid ! stop;
        _ ->
            loop(Pid)
    end.
