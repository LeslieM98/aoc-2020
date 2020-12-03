:- include("../io_util.pl").
:- use_module(library(clpfd)).

counter([], _, 0).
counter([E|Es], E, Count) :-
    counter(Es, E, Acc), !,
    Count is Acc + 1.
counter([_|Es], E, Count) :- counter(Es, E, Count).

gen_path_d1(_Right, _Depth, [], []).
gen_path_d1(Right, Depth, [Line|Inputs], Path) :- 
    string_chars(Line, Chars),
    length(Chars, Len),
    Modulo is (Depth * Right) mod Len,
    nth0(Modulo, Chars, Value),

    New_Depth is Depth + 1,
    gen_path_d1(Right, New_Depth, Inputs, Result),
    Path = [Value|Result], !.

gen_path_d2(_Depth, [], []).
gen_path_d2(_Depth, [_Ignored], []).
gen_path_d2(Depth, [Line, _Skipped|Inputs], Path) :- 
    string_chars(Line, Chars),
    length(Chars, Len),
    Modulo is Depth mod Len,
    nth0(Modulo, Chars, Value),

    New_Depth is Depth + 1,
    gen_path_d2(New_Depth, Inputs, Result),
    Path = [Value|Result], !.

solution1(Inputs, Result) :- 
    gen_path_d1(3, 0, Inputs, Path),
    counter(Path, #, Result).
    
solution2(Inputs, Result) :-
    gen_path_d1(1, 0, Inputs, Path1),
    gen_path_d1(3, 0, Inputs, Path2),
    gen_path_d1(5, 0, Inputs, Path3),
    gen_path_d1(7, 0, Inputs, Path4),
    gen_path_d2(0, Inputs, Path5),
    counter(Path1, #, Trees1),
    counter(Path2, #, Trees2),
    counter(Path3, #, Trees3),
    counter(Path4, #, Trees4),
    counter(Path5, #, Trees5),
    Result is Trees1 * Trees2 * Trees3 * Trees4 * Trees5.

    
main :-
    get_puzzle_inputs("istannen.txt", Inputs),
    solution1(Inputs, Solution1),
    solution2(Inputs, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).
