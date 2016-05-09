%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #2: Creating lists
%%% Created : 4 Feb 2016
%%%-------------------------------------------------------------------

-module(create).

-export([create/1, reverse_create/1]).

%% @doc Given an integer, it returns a list of all the integers from 0 to that integer.
%% @spec create(Value :: integer()) -> [integer()]
create(N) ->
	create_acc(1, (N+1)).

create_acc(N, Lim) ->
	case N of
		Lim -> [];
		_ -> [N|create_acc(N+1, Lim)]
	end.

%% @doc Given an integer, it returns a list of all the integers from that integer to 0.
%% @spec reverse_create(Value :: integer()) -> [integer()]
reverse_create(N) ->
	case N of
		0 -> [];
		_ -> [N|reverse_create(N-1)]
	end.
