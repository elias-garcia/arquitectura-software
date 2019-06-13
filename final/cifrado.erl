%%% -*- coding: utf-8 -*-
%%%-----------------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @end
%%%-----------------------------------------------------------------------------

-module(cifrado).

-export([caesar/2]).

caesar(Char, Key) when (Char >= $A) and (Char =< $Z) or (Char >= $a) and (Char =< $z) ->
    Offset = $A + Char band 32,
    N = Char - Offset,
    Offset + (N + Key) rem 26;
caesar(Char, _Key) ->
    Char.
