:- use_module(library(clpfd)).

read_input_lines_codes(_, Acc, Acc).
read_input_lines_codes(Stream, Out) :- 
    read_line_to_string(Stream, Line),
    Line \= end_of_file,
    Line \= "",
    read_input_lines_codes(Stream, OutR),
    Out = [Line | OutR], !.

read_input_lines_codes(Stream, Out) :- 
    read_input_lines_codes(Stream, Out, []).

get_puzzle_inputs(Inputs) :- get_puzzle_inputs("input.txt", Inputs).
get_puzzle_inputs(Filepath, Inputs):- 
    open(Filepath, read, File),
    read_input_lines_codes(File, Inputs),
    close(File).

% ACTUAL PUZZLE

contains(E, [E|_]).
contains(C, [_|Es]) :- contains(C, Es).

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