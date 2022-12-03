#lang datalog

% include + and - as queries, as suggested by the fib example of
% https://docs.racket-lang.org/datalog/datalog.html
(racket/base).

% package(Elf, Layer, Weight) - I couldn't find a way to do sum(),
% so I'm doing it as a series of + operations
package(1, 1, 1000).
package(1, 2, 2000).
package(1, 3, 3000).

package(2, 1, 4000).

package(3, 1, 5000).
package(3, 2, 6000).

package(4, 1, 7000).
package(4, 2, 8000).
package(4, 3, 9000).

package(5, 1, 10000).

runningtotoal(Elf, Layer, Total) :- package(Elf, Layer, Weight), Total :- Weight.

runningtotal(1, 1, Total)?

