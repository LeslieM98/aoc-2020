:- module(input_loader,[get_puzzle_inputs/2]).

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