%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #1: Simple pattern matching
%%% Created : 4 Feb 2016
%%%-------------------------------------------------------------------

-module(boolean).

-export([b_not/1, b_and/2, b_or/2]).

%% @doc Given one boolean, returns it's negation.
%% @spec b_not(Value :: boolean()) -> boolean()
b_not(true) -> false;
b_not(false) -> true;
b_not(_) -> error(bad_argument).

%% @doc Given two booleans, returns it's AND logic operation.
%% @spec b_and(Value1 :: boolean(), Value2 :: boolean()) -> boolean()
b_and(true, true) -> true;
b_and(true, false) -> false;
b_and(false, false) -> false;
b_and(false, true) -> false;
b_and(_, _) -> error(bad_argument).

%% @doc Given two booleans, returns it's AND logic operation.
%% @spec b_or(Value1 :: boolean(), Value2 :: boolean()) -> boolean()
b_or(true, true) -> true;
b_or(true, false) -> true;
b_or(false, false) -> false;
b_or(false, true) -> true;
b_or(_, _) -> error(bad_argument).
