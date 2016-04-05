%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #4: List manipulation
%%% Created : 15 Feb 2016
%%%-------------------------------------------------------------------

- module(manipulating).

- export([filter/2, reverse/1, concatenate/1]).

filter([H|T], N) when H =< N ->
	[H|filter(T, N)];
filter([_|T], N) ->
	filter(T, N);
filter([], _) ->
	[].

reverse(L) ->
	reverse(L, []).

reverse([H|T], Acc) ->
	reverse(T, [H|Acc]);
reverse([], Acc) ->
	Acc.

	concatenate(List) -> concatenate(List, []).

	concatenate([[H|T]|List], Aux) -> concatenate([T|List], [H|Aux]);
	concatenate([[]|List], Aux) -> concatenate(List, Aux);
	concatenate(List, Aux)-> reverse(Aux).


	flatten(List) -> reverse(flatten(List, [])).
	
	flatten([], Aux) -> Aux;
	flatten([H|T], Aux) when is_list(H) -> flatten(T, flatten(H, Aux));
	flatten([H|T], Aux) -> flatten(T, [H|Aux]).
