:- use_module("input_loader", [get_puzzle_inputs/2]).

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

day_module(Day, Module) :- 
    day_predicate(Day, Day_Str),
    string_concat(Day_Str, "/", Left),
    string_concat(Left, Day_Str, Module).

load_module(Day) :-
    day_module(Day, Module),
    day_predicate(Day, Predicate),
    string_concat("[main/3 as ", Predicate, Left),
    string_concat(Left, "]", Import_Str),
    string_to_atom(Import_Str, Import_Atom),
    atom_to_term(Import_Atom, Import, []),
    call(use_module, Module, Import).

execute_puzzle(Day, Expected_Part1, Expected_Part2) :-
    load_module(Day),

    day_path(Day, Path),
    get_puzzle_inputs(Path, D1_Input),
    day_predicate(Day, Predicate),
    statistics(walltime, [_ | [_]]),
    call(Predicate, D1_Input, D1P1, D1P2),
    statistics(walltime, [_ | [ExecutionTime]]),
    write(Predicate), writeln(":"),
    write("part1 expected: "), writeln(Expected_Part1), 
    write("part1 actual:   "), writeln(D1P1),
    write("part2 expected: "), writeln(Expected_Part2), 
    write("part2 actual:   "), writeln(D1P2), 
    write('Execution took '), write(ExecutionTime), writeln(' ms.'), nl.

main :-
    execute_puzzle(1, "898299", "143933922"),
    execute_puzzle(2, "447", "249"),
    execute_puzzle(3, "223", "3517401300"),
    execute_puzzle(4, "228", "175"),
    execute_puzzle(5, "832", "517"),
    execute_puzzle(6, "6596", "3219"),
    execute_puzzle(7, "144", "5956"),
    execute_puzzle(8, "1797", "1036"),

    halt.
:- main.