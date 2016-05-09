%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #6: Key Value Storage
%%% Created : 6 Apr 2016
%%%-------------------------------------------------------------------

-module(db).

-export([new/0, write/3, delete/2, read/2, match/2, destroy/1, reverse/1]).

% Aux function (List manipulation)
reverse(List) -> reverse(List, []).
reverse([H|T], List2) -> reverse(T, [H|List2]);
reverse([], List2) -> List2.

% DB
%% @doc Create the data repository.
%% @spec new() -> List()
new() ->[].

%% @doc Inserts a new element in the data repository.
%% @spec write(Key, Element, DbRef) -> NewDbRef
write(Key, Element, DbRef) -> [{Key,Element}|DbRef].

%% @doc Removes the first occurrence of 'Key' in the data repository 'DbREf'.
%% @spec delete(Key, DbRef) -> NewDbRef
%% @end
delete(Key, DbRef) -> delete(Key, DbRef, []).

delete(_Key, [], NewDbRef) -> reverse(NewDbRef);
delete(Key, [{Key, _Element}|T], NewDbRef) -> delete(Key, T, NewDbRef);
delete(Key, [H|T], NewDbRef) -> delete(Key, T, [H|NewDbRef]).

%% @doc Returns the firs ocurrence of 'Key' in the data storage or returns an error if it doesn't exist.
%% @spec read(Key, DbRef) -> {ok, Element} | {error, instance}
read(_Key, []) -> {error, instance};
read(Key, [{Key, Element}|_T]) -> {ok, Element};
read(Key, [{_Key, _Element}|T]) -> read(Key, T).

%% @doc Returns all keys containing the 'Element' value.
%% @spec match(Element, DbRef) -> [Key, ..., KeyN]`
match(Element, DbRef) -> match(Element, DbRef, []).

match(_Element, [], ListElement) -> reverse(ListElement);
match(Element, [{Key, Element}|T], ListElement) -> match(Element, T, [Key|ListElement]);
match(Element, [_H|T], ListElement) -> match(Element, T, ListElement).

%% @doc Removes the data repositorty "DbRef".
%% @spec destroy(DbRef) -> ok
destroy(_DbRef) -> ok.
