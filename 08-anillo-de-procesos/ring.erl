-module(ring).

-export([start/3, init/3, loop/1]).

start(ProcNum, MsgNum, Message) ->
    Master = spawn(ring, init, [ProcNum, MsgNum, Message]),
    register(master, Master),
    ok.

init(1, MsgNum, Message) ->
    Master = whereis(master),
    Master ! {MsgNum-1, Message},
    loop(Master);
init(ProcNum, MsgNum, Message) ->
    Slave = spawn(ring, init, [ProcNum-1, MsgNum, Message]),
    loop(Slave).

loop(Pid) ->
    receive
        {0, _Message} ->
            Pid ! stop,
            unregister(master);
        {MsgNum, Message} ->
            Pid ! {MsgNum-1, Message},
            loop(Pid);
    stop ->
        Pid ! stop;
    _ ->
        loop(Pid)
  end.
