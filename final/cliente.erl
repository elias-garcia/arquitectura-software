%%% -*- coding: utf-8 -*-
%%%-----------------------------------------------------------------------------
%%% @author Elías García <elias.garcia@udc.es>
%%% @copyright (C) 2015, Elías García
%%% @end
%%%-----------------------------------------------------------------------------

-module(cliente).

-export([start/1, send/2, regist/2, logout/0]).

-define(PID_U, pid_U).

-import(cifrado, [caesar/2]).

server_name () ->
	servidor@hostname. % Reemplazar "hostname" por el nombre de su equipo.

start(User) ->
	PidServer = whereis(?PID_U),
	case(PidServer) of
		undefined ->
			register(?PID_U, spawn(cliente, regist, [server_name(), User]));
		_PidServer ->
			io:format("Ya estas registrado.~n")
	end.

regist(Server_name, User)->
	{servidor, Server_name} ! {regist, User, self() },
	receive
		{stop, Why} ->
			io:format("~p~n", [Why]),
			exit(normal);
		{ok, exito} ->
			io:format("Te has registrado correctamente.~n"),
			manager(Server_name)
	end.

manager(Server_name)->
	receive
		{FromName, Msg} ->
			io:format("~p:  ~p~n",[FromName, Msg]),
			manager(Server_name);
		{send, Dest, Message} ->
			{servidor, Server_name} ! {send, self(), Dest, Message},
			manager(Server_name);
		{recibir, From, Msg} ->
			io:format("~p:  ~p~n", [From, cifrado:caesar(Msg,-10)]),
			manager(Server_name);
		{logout} ->
			{servidor, Server_name} ! {logout, self()},
			closeSession(Server_name)
	end.

send(Dest, Message) ->
	case whereis(?PID_U) of
        undefined ->
			io:format("El mensaje no se ha podido enviar.~n");
    	PidServer ->
			PidServer ! {send, Dest, cifrado:caesar(Message,10)},enviado
	end.

closeSession(_Server_name) ->
	receive
		{ok} -> io:format("Desconectado. Adios!~n"),
		exit(normal)
	end.

logout() ->
	case whereis(?PID_U) of
		undefined -> io:format("No estas logueado.~n");
		PidBuzon -> PidBuzon ! {logout}
	end.
