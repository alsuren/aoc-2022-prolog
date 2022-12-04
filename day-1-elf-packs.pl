

package(empty, elf_1_1, 1000).
package(elf_1_1, elf_1_2, 2000).
package(elf_1_2, elf_1_3, 3000).

package(empty, elf_2_1, 4000).

package(empty, elf_3_1, 5000).
package(elf_3_1, elf_3_2, 6000).

package(empty, elf_4_1, 7000).
package(elf_4_1, elf_4_2, 8000).
package(elf_4_2, elf_4_3, 9000).

package(empty, elf_5_1, 10000).

total(empty, 0).
total(Position, Weight) :- 
    package(NextPosition, Position, W1),
    total(NextPosition, W2),
    plus(W1, W2, Weight).

solution(Max) :- findall(W, total(_, W), Result), max_list(Result, Max).

?- solution(Max), write_ln(Max).

?- halt.
