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


contains(E, [E|_]).
contains(C, [_|Es]) :- contains(C, Es).

solve_part1(Inputs, Out) :- 
    2020 #= X + Y,
    Out #= X * Y,
    maplist(number_string, Integers, Inputs),
    contains(X, Integers),
    contains(Y, Integers),
    label([Out]).



main :-
    open("input.txt", read, File),
    read_input_lines_codes(File, Inputs),
    close(File),
    solve_part1(Inputs, Solution1),
    writeln(Solution1).