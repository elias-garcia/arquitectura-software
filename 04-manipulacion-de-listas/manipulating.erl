%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #4: List manipulation
%%% Created : 15 Feb 2016
%%%-------------------------------------------------------------------

- module(manipulating).

- export([filter/2, reverse/1, concatenate/1, flatten/1]).

%% @doc Given a list of integers and an integer, it returns a list containing the elements of the list which are smaller or equal to that number.
%% @spec filter(List :: [integer()], I :: integer()) -> [integer()]
filter([H|T], N) when H =< N ->
	[H|filter(T, N)];
filter([_|T], N) ->
	filter(T, N);
filter([], _) ->
	[].

%% @doc Given a list of integers, it returns the same list in reverse order.
%% @spec reverse(List :: [integer()]) -> [integer()]
reverse(L) ->
	reverse(L, []).

reverse([H|T], Acc) ->
	reverse(T, [H|Acc]);
reverse([], Acc) ->
	Acc.

%% @doc Given a list of lists, it returns all of those lists concatenated.
%% @spec concatenate(List :: [list()]) -> list()
concatenate(List) -> concatenate(List, []).

concatenate([[H|T]|List], Aux) -> concatenate([T|List], [H|Aux]);
concatenate([[]|List], Aux) -> concatenate(List, Aux);
concatenate(List, Aux)-> reverse(Aux).

%% @doc Given a list of lists, it returns a list with all of those lists flatten.
%% @spec flatten(List :: [lists()]) -> list()
%% @end
flatten(List) -> reverse(flatten(List, [])).

flatten([], Aux) -> Aux;
flatten([H|T], Aux) when is_list(H) -> flatten(T, flatten(H, Aux));
flatten([H|T], Aux) -> flatten(T, [H|Aux]).
