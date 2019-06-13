%%% -*- coding: utf-8 -*-
%%%-----------------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @end
%%%-----------------------------------------------------------------------------

-module(supervisor_servidor).

-behaviour(supervisor).

%% API
-export([start/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%% API functions
start() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% Supervisor callbacks
init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 500,
    MaxSecondsBetweenRestarts = 1,
    Flags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    Restart = permanent,
    Shutdown = 2000,
    Type = worker,
    Servidor = {servidor, {servidor, start, []}, Restart, Shutdown, Type, [servidor]},
    {ok, {Flags, [Servidor]}}.
