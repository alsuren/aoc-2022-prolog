#lang datalog

% include + and - as queries, as suggested by the fib example of
% https://docs.racket-lang.org/datalog/datalog.html
(racket/base).

% package(Elf, Layer, Weight) - I couldn't find a way to do sum(),
% so I'm doing it as a series of + operations
package(1, 11, 1000).
package(1, 12, 2000).
package(1, 13, 3000).

package(2, 21, 4000).

package(3, 31, 5000).
package(3, 32, 6000).

package(4, 41, 7000).
package(4, 42, 8000).
package(4, 43, 9000).

package(5, 51, 10000).

runningtotal(1, 10, 0).
runningtotal(2, 20, 0).
runningtotal(3, 30, 0).
runningtotal(4, 40, 0).
runningtotal(5, 50, 0).
%runningtotoal(Elf, Layer, Total) :-
%  Layer :- *(Elf, 10),
%  package(Elf, Layer, 0).
runningtotoalxxx(Elf, Layer, Total) :-
  LayerBelow :- -(Layer, 1),
  BottomLayer :- *(Elf, 10),
  Layer != BottomLayer,
  package(Elf, Layer, T1),
  runningtotoal(Elf, LayerBelow, T2),
  Total :- +(T1, T2).

% runningtotoal(1, 1, Total)?
runningtotoal(4, 40, Total)?
% runningtotoal(Elf, Layer, Total)?
