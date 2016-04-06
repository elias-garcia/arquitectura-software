-module(echo).

-export([start/0, stop/0, print/1, loop/0]).

start() -> register(echo, spawn(echo, loop, [])),
           ok.

stop() -> echo ! stop,
          unregister(echo),
          ok.

print(Term) -> echo ! {print, Term},
               ok.

loop() -> receive
              stop -> {ok, self()};
              {print, Term} -> io:format("~p~n", [Term]), loop();
              _ -> loop(), ok
          end.
