:- use_module(library(error)).

% This is the structure of the example. I decided on this structure
% when I was still trying to do it in Datalog.
% The idea is that you make a bunch of graph routes from `empty` to `full`,
% and each edge weight is the calorific value of the package.
% Once you have all of the packages encoded in a knowledge graph, you can
% query it to find the most calorific bags.
%
% package(empty, elf_1_1, 1000).
% package(elf_1_1, elf_1_2, 2000).
% package(elf_1_2, elf_1_3, 3000).
% package(elf_1_3, full, 0).
%
% package(empty, elf_2_1, 4000).
% package(elf_2_1, full, 0).
%
% package(empty, elf_3_1, 5000).
% package(elf_3_1, elf_3_2, 6000).
% package(elf_3_2, full, 0).
%
% package(empty, elf_4_1, 7000).
% package(elf_4_1, elf_4_2, 8000).
% package(elf_4_2, elf_4_3, 9000).
% package(elf_4_3, full, 0).
%
% package(empty, elf_5_1, 10000).
% package(elf_5_1, full, 0).

total(empty, 0).
total(Position, Weight) :- 
    package(NextPosition, Position, W1),
    total(NextPosition, W2),
    plus(W1, W2, Weight).

solution(TopThree) :- 
    findall(W, total(full, W), Result),
    sort(0, @>=, Result, Sorted),
    [One, Two, Three | _] = Sorted,
    TopThree is One + Two + Three.

% This is the bit that does the file parsing and populates the knowledge graph.
% It started as copy-paste from https://www.swi-prolog.org/FAQ/ReadDynamicFromFile.html.
% I noticed that it looked a lot like Erlang (recursive code with side-effects),
% and there is no back-tracking because of the `!`s sprinkled around the place.
% This intrigued me, so I looked it up. Apparently Erlang started life as a modified prolog.
load_arcs(File) :-
    retractall(arc(_,_)),
    setup_call_cleanup(
        open(File, read, Stream),
        load_arcs_from_stream(1, "", Stream),
        close(Stream)).

load_arcs_from_stream(I, Prev, Stream) :- !,
    read_line_to_string(Stream, T0),
    load_arcs_from_line(I, Prev, T0, Stream).

load_arcs_from_line(_, _, end_of_file, _Stream) :- !.
load_arcs_from_line(I, Prev, Line, Stream) :- !,
    I1 is I+1, % FIXME: I1 is I-1 above. Think of better names?
    assert_fact(I1, Prev, Line),
    load_arcs_from_stream(I1, Line, Stream).

assert_fact(I, "", Line) :-
    number_string(Number, Line),
    write_ln((empty, I, Number)),
    assert(package(empty, I, Number)).
assert_fact(I, _Prev, "") :- !,
    I1 is I-1,
    assert(package(I1, full, 0)).
assert_fact(I, _Prev, Line) :-
    I1 is I-1,
    number_string(Number, Line),
    write_ln((I1, I, Number)),
    assert(package(I1, I, Number)).

?- load_arcs("day-1-input").
?- write_ln("========================").
?- solution(Max), write_ln(Max).

?- halt.
