:- use_module(library(clpfd)).
:- include("../aoc_util.pl").

solve_part1(Integers, Out) :- 
    2020 #= X + Y,
    Out #= X * Y,
    contains(X, Integers),
    contains(Y, Integers),
    label([Out]).

solve_part2(Integers, Out) :-
    2020 #= X + Y + Z,
    Out #= X * Y * Z,
    contains(X, Integers),
    contains(Y, Integers),
    contains(Z, Integers),
    label([Out]).

main :-
    get_puzzle_inputs(Inputs),
    maplist(number_string, Integers, Inputs),
    solve_part1(Integers, Solution1), !,
    solve_part2(Integers, Solution2), !,
    writeln(Solution1),
    writeln(Solution2).