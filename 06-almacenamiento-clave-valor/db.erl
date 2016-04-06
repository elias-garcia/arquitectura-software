-module(db).

-export([new/0, write/3, delete/2, read/2, match/2, destroy/1, reverse/1]).

% Función Auxiliar (List manipulation)
reverse(List) -> reverse(List, []).
reverse([H|T], List2) -> reverse(T, [H|List2]);
reverse([], List2) -> List2.

% DB
new() ->[].

write(Key, Element, DbRef) -> [{Key,Element}|DbRef].

delete(Key, DbRef) -> delete(Key, DbRef, []).

delete(_Key, [], NewDbRef) -> reverse(NewDbRef);
delete(Key, [{Key, _Element}|T], NewDbRef) -> delete(Key, T, NewDbRef);
delete(Key, [H|T], NewDbRef) -> delete(Key, T, [H|NewDbRef]).

read(_Key, []) -> {error, instance};
read(Key, [{Key, Element}|_T]) -> {ok, Element};
read(Key, [{_Key, _Element}|T]) -> read(Key, T).

match(Element, DbRef) -> match(Element, DbRef, []).

match(_Element, [], ListElement) -> reverse(ListElement);
match(Element, [{Key, Element}|T], ListElement) -> match(Element, T, [Key|ListElement]);
match(Element, [_H|T], ListElement) -> match(Element, T, ListElement).

destroy(_DbRef) -> ok.
