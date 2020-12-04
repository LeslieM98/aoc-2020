:- use_module("input_loader", [get_puzzle_inputs/2]).
:- use_module("day01/day01", [main/3 as day01]).
:- use_module("day02/day02", [main/3 as day02]).
:- use_module("day03/day03", [main/3 as day03]).

daynr_string(Day_Nr, Str) :- 
    Day_Nr > 9,
    number_string(Day_Nr, Str), !.
daynr_string(Day_Nr, Str) :-
    Day_Nr < 10,
    number_string(Day_Nr, Day_Nr_Str),
    string_chars(Day_Nr_Str, Day_Nr_Chars),
    Char_Result = ['0'|Day_Nr_Chars],
    string_chars(Str, Char_Result), !.

day_predicate(Day, Predicate_Name) :-
    daynr_string(Day, Day_Str),
    atom_concat('day', Day_Str, Predicate_Name).

day_path(Day, Path) :- 
    daynr_string(Day, Day_Str),
    string_concat("day", Day_Str, Dir),
    string_concat(Dir, "/input.txt", Path).

execute_puzzle(Day) :-
    day_path(Day, Path),
    get_puzzle_inputs(Path, D1_Input),
    day_predicate(Day, Predicate),
    call(Predicate, D1_Input, D1P1, D1P2),
    % day01(D1_Input, D1P1, D1P2),
    writeln(D1P1),
    writeln(D1P2).

main :-
    execute_puzzle(1),
    execute_puzzle(2),
    execute_puzzle(3).