%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #7: Echo Server
%%% Created : 6 Apr 2016
%%%-------------------------------------------------------------------

-module(echo).

-export([start/0, stop/0, print/1, loop/0]).

%% @doc Starts the echo server.
%% @spec echo:start() -> ok`
start() ->
    register(echo, spawn(echo, loop, [])),
    ok.

%% @doc Stops the echo server.
%% @spec echo:stop() -> ok
stop() ->
    echo ! stop,
    unregister(echo),
    ok.

%% @doc Prints 'Term' in the screen.
%% @spec echo:print(Term) -> ok
print(Term) ->
    echo ! {print, Term},
    ok.

%% @doc Keeps the server waiting for a message.
%% @spec
loop() ->
    receive
        stop -> {ok, self()};
        {print, Term} -> io:format("~p~n", [Term]), loop();
        _ -> loop(), ok
    end.
