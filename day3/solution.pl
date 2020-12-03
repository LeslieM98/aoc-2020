:- include("../io_util.pl").
:- use_module(library(clpfd)).

counter([], _, 0).
counter([E|Es], E, Count) :-
    counter(Es, E, Acc), !,
    Count is Acc + 1.
counter([_|Es], E, Count) :- counter(Es, E, Count).

gen_path(_Depth, [], []).
gen_path(Depth, [Line|Inputs], Path) :- 
    string_chars(Line, Chars),
    length(Chars, Len),
    Modulo is (Depth * 3) mod Len,
    nth0(Modulo, Chars, Value),

    New_Depth is Depth + 1,
    gen_path(New_Depth, Inputs, Result),
    Path = [Value|Result], !.

solution1(Input, Result) :- 
    gen_path(0, Inputs, Path),
    counter(Path, #, Result).
    
main :-
    get_puzzle_inputs(Inputs),
    solution1(Inputs, Solution1),
    write("Part1: "), writeln(Solution1).
