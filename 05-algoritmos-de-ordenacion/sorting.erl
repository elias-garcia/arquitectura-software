%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #5: Sorting Lists
%%% Created : 5 Apr 2016
%%%-------------------------------------------------------------------

-module(sorting).

-export([quicksort/1, mergesort/1]).

%% @doc Given a list of integers, it returns a list sorted using quicksort.
%% @spec quicksort(List :: [integer()]) -> [integer()]
quicksort([Pivote|T]) ->
    quicksort([ X || X <- T, X < Pivote]) ++ [Pivote] ++
        quicksort([ X || X <- T, X >= Pivote]);
quicksort([]) -> [].

merge(L, [])  -> L;
merge([], R)  -> R;
merge([L|Left], [R|Right])  ->
    if
        L < R   -> [L | merge(Left, [R|Right])];
        L >= R  -> [R | merge([L|Left], Right)]
    end.

%% @doc Given a list of integers, it returns a list sorted using mergesort.
%% @spec mergesort(List :: [integer()]) -> [integer()]
%% @end
mergesort([])   -> [];
mergesort([H])  -> [H];
mergesort(List) ->
    {L, R} = lists:split(length(List) div 2, List),
        merge(mergesort(L), mergesort(R)).
