-module(sorting).
-export([quicksort/1, mergesort/1]).

quicksort([Pivote|T]) ->
    quicksort([ X || X <- T, X < Pivote]) ++
    [Pivote] ++
    quicksort([ X || X <- T, X >= Pivote]);
quicksort([]) -> [].

merge(L, [])  -> L;
merge([], R)  -> R;
merge([L|Left], [R|Right])  ->
    if
        L < R   -> [L | merge(Left, [R|Right])];
        L >= R  -> [R | merge([L|Left], Right)]
    end.

mergesort([])   -> [];
mergesort([H])  -> [H];
mergesort(List) ->
    {L, R} = lists:split(length(List) div 2, List),
    merge(mergesort(L), mergesort(R)).
