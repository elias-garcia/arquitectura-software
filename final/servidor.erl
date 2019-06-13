%%% -*- coding: utf-8 -*-
%%%-----------------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @end
%%%-----------------------------------------------------------------------------

-module(servidor).

-export([start/0, loop/1, searchUser/2]).

-define(SERVER_NAME, servidor).

start() ->
	register(servidor, spawn(servidor, loop, [[]]) ).

loop(ListUsers) ->
	receive
		{logout, FromPid} ->
			FromPid ! {ok},
			loop(deleteUser(ListUsers, {searchUser(ListUsers, FromPid),FromPid}));
        {regist, User, Pid} ->
			loop (registUser(Pid, User, ListUsers));
        {send, PidOrigen, Dest, Message} ->
        	case searchPid(ListUsers, Dest) of
				-1 ->
					PidOrigen ! {notfound},
					loop(ListUsers);
		        PidDest ->
					PidDest ! {recibir, searchUser(ListUsers, PidOrigen),
					cifrado:caesar(Message,10)},
				 	io:format("Mensaje recibido de: ~p, se le envia a: ~p~n",[PidOrigen,Dest]),
				  	loop(ListUsers)
            end
	end.

registUser(From, User, ListUsers)->
	case lists:keymember(User, 1, ListUsers) of
		false ->
			io:format("Usuario ~p [~p] registrado en el servidor~n", [User, From]),
			From ! {ok, exito},
			[{User, From} | ListUsers];
		true ->
			From ! {stop, usuario_ya_registrado},
			ListUsers
	end.

deleteUser(ListUsers, User) ->
	lists:delete(User, ListUsers).

searchPid([], _User) -> io:format("El usuario no esta registrado.~n"), -1;
searchPid([{User, Pid}|_], User) -> Pid;
searchPid([{_User, _Pid}|T], User) -> searchPid(T, User).

searchUser([], _Pid) -> io:format("El usuario no esta registrado.~n"), -1;
searchUser([{User, Pid}|_], Pid) -> User;
searchUser([{_User, _Pid}|T], Pid) -> searchUser(T, Pid).
