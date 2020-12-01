% :- use_module(library(clpfd)).
read_input_lines_codes(_, Acc, Acc).
read_input_lines_codes(Stream, Out) :- 
    read_line_to_string(Stream, Line),
    Line \= end_of_file,
    Line \= "",
    read_input_lines_codes(Stream, OutR),
    Out = [Line | OutR].

read_input_lines_codes(Stream, Out) :- 
    read_input_lines_codes(Stream, Out, []).
    % read_string(Stream, "\n", "", _, Out

part1(Out) :-
    open("input.txt", read, File),
    read_input_lines_codes(File, Out).