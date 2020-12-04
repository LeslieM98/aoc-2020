:- module(day01,[main/3, main/0]).


:- use_module(library(clpfd)).
:- use_module("../aoc_util").
:- use_module("../input_loader",[get_puzzle_inputs/1]).

solve_part1(Integers, Out) :- 
    2020 #= X + Y,
    Out #= X * Y,
    contains(X, Integers),
    contains(Y, Integers),
    label([Out]).

solve_part2(Integers, Out) :-
    2020 #= X + Y + Z,
    Out #=  X * Y * Z,
    contains(X, Integers),
    contains(Y, Integers),
    contains(Z, Integers),
    label([Out]).

main(Input, Solution1, Solution2) :-
    maplist(number_string, Integers, Input),
    solve_part1(Integers, Solution1), !,
    solve_part2(Integers, Solution2), !.

main :-
    get_puzzle_inputs(Input),
    main(Input, Solution1, Solution2),
    writeln(Solution1),
    writeln(Solution2).
