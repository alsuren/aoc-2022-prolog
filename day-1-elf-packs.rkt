#lang datalog

% include + and - as queries, as suggested by the fib example of
% https://docs.racket-lang.org/datalog/datalog.html
(racket/base).

% package(Elf, Layer, Weight) - I couldn't find a way to do sum(),
% so I'm doing it as a series of + operations
package(1, 1, 2, 1000).
package(1, 2, 3, 2000).
package(1, 3, 4, 3000).

package(2, 1, 2, 4000).

package(3, 1, 2, 5000).
package(3, 2, 3, 6000).

package(4, 1, 2, 7000).
package(4, 2, 3, 8000).
package(4, 3, 4, 9000).

package(5, 1, 2, 10000).

runningtotal(1, 0, 0).
runningtotal(2, 0, 0).
runningtotal(3, 0, 0).
runningtotal(4, 0, 0).
runningtotal(5, 0, 0).
%runningtotoal(Elf, Layer, Total) :-
%  Layer :- *(Elf, 10),
%  package(Elf, Layer, 0).
runningtotoal(Elf, Layer, Total) :-
  package(Elf, LayerBelow, Layer, T1),
  runningtotoal(Elf, LayerBelow, T2),
  Total :- +(T1, T2).

 runningtotoal(1, 1, Total)?
% runningtotoal(4, 40, Total)?
%runningtotoal(Elf, Layer, Total)?
