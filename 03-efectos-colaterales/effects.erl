%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #3: Collateral effects
%%% Created : 15 Feb 2016
%%%-------------------------------------------------------------------

- module(effects).

- export([print/1, even_print/1]).

%% @doc Given an integer, it prints on screen all numbers between 1 and N.
%% @spec print(Value :: integer()) -> Screen output
print(N) ->
	print_acc(N, 1).

print_acc(N, Acc) when (N == Acc)->
	io:format("~p - ", [Acc]);
print_acc(N, Acc) ->
	io:format("~p - ", [Acc]),
	print_acc(N, Acc+1).

%% @doc Given an integer, it prints on screen all even numbers between 1 and N.
%% @spec print(Value :: integer()) -> Screen output
even_print(N) ->
	even_print_acc(N, 1).

even_print_acc(N, Acc) ->
	case Acc of
		N when (Acc rem 2 == 0) ->
			io:format("~p - ", [Acc]);
		N -> ok;
		_ when (Acc rem 2 == 0) ->
			io:format("~p - ", [Acc]),
			even_print_acc(N, Acc+1);
		_ ->
			even_print_acc(N, Acc+1)
	end.
