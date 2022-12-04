% From https://www.reddit.com/r/adventofcode/comments/z9ezjb/comment/iyiu5e2/
:- use_module(library(dcg/basics)).
:- use_module(library(pio)).

% The solution from reddit has:
%
%     elf([]) --> eol.
%     elf([Item|Items]) --> number(Item), eol, elf(Items).
%
% `listing(elf)` says that this expands to (after renaming some variables manually):
elf([], A, Rest) :-
    eol(A, Rest).
% and:
elf([Item|Items], A, Rest) :-
    number(Item, A, B),
    eol(B, C),
    elf(Items, C, Rest).
% also, if you're interested, `eol` is:
% dcg_basics:eol([10|A], Rest) :-
%     !,
%     Rest=A.
% ...
% (10 is the ascii code for '\n', and there is another variant for \r\n) 
%
% `number` is a bit more gnarly, so I've not expanded it here.
%
% As I understand it, when the compiler desugars `-->` it adds two lists to each of your predicates.
% The difference between the first list and the second is the bit that
% your predicate "consumes" while parsing. It can also *produce* this difference,
% if you want reverse the parsing process (in theory). This is the "list difference"
% thing that is decribed on this slide: https://youtu.be/CvLsVfq6cks?t=720
%
% In this case, the difference between A and C is a `number` and an `eol`.

% The reddit solution also has:
%
%     elves([]) --> eos.
%     elves([ElfLoad|ElfLoads]) --> elf(Items), {sumlist(Items, ElfLoad)}, elves(ElfLoads).
%
% which expands to:
elves([], A, Rest) :-
    eos(A, Rest).
elves(MoreElfLoads, A, Rest) :-
    % I made this destructuring explicit manually so that I could speak about it with more clarity.
    MoreElfLoads = [ElfLoad|ElfLoads],
    elf(Items, A, B),
    % The bit inside the {} doesn't get messed around with.
    % `ElfLoad` ends up as the sum of `Items`.
    sumlist(Items, ElfLoad),
    elves(ElfLoads, B, Rest).
% In this case, the difference between A and B is an `elf`.
% Its Items are summed and added to MoreElfLoads.

% eos is "end of stream", which expands to this simple fact:
% dcg_basics:eos([], []).

main :-
    File = 'day-1-input',
    phrase_from_file(elves(Es), File),
    sort(0, @>=, Es, [Part1,Elf2,Elf3|_]),
    sum_list([Part1,Elf2,Elf3], Part2),
    format('Part 1: ~w~nPart2: ~w~n', [Part1, Part2]),
    halt.

?- main.
% ?- listing(eos), halt.
