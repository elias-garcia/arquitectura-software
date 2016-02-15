%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #1: Simple pattern matching
%%% Created : 4 Feb 2016
%%%-------------------------------------------------------------------

-module(create).

-export([create/1, reverse_create/1]).

create(N) ->
	create_acc(1, (N+1), []).

create_acc(N, Lim, Acc) ->
	case N of
		Lim -> Acc;
		_ -> create_acc(N+1, Lim, Acc++[N])
	end.

reverse_create(N) ->
	reverse_create_acc(N, []).

reverse_create_acc(N, Acc) ->
	case N of
		0 -> Acc;
		_ -> reverse_create_acc(N-1, Acc++[N])
	end.