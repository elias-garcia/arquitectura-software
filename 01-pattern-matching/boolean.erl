%%%-------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @doc Assignment #1: Simple pattern matching
%%% Created : 4 Feb 2016
%%%-------------------------------------------------------------------

-module(boolean).

-export([b_not/1, b_and/2, b_or/2]).

b_not(true) -> false;
b_not(false) -> true;
b_not(_) -> error(bad_argument).

b_and(true, true) -> true;
b_and(true, false) -> false;
b_and(false, false) -> false;
b_and(false, true) -> false;
b_and(_, _) -> error(bad_argument).

b_or(true, true) -> true;
b_or(true, false) -> true;
b_or(false, false) -> false;
b_or(false, true) -> true;
b_or(_, _) -> error(bad_argument).