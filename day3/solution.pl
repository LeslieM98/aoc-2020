:- include("../io_util.pl").
:- use_module(library(clpfd)).

counter([], _, 0).
counter([E|Es], E, Count) :-
    counter(Es, E, Acc), !,
    Count is Acc + 1.
counter([_|Es], E, Count) :- counter(Es, E, Count).

remove_n(0, In, In) :- !.
remove_n(_, [], []) :- !.
remove_n(N, [_|Ins], Out) :-
    New_N is N - 1,
    remove_n(New_N, Ins, Out).


gen_path(Slope, Inputs, Path) :- gen_path(Slope, 0, Inputs, Path).

gen_path(_Slope, _Depth, [], []).
gen_path([Right, Down], Depth, [Line|Inputs], Path) :- 
    string_chars(Line, Chars),
    length(Chars, Len),
    Modulo is (Depth * Right) mod Len,
    nth0(Modulo, Chars, Value),

    New_Depth is Depth + 1,
    Skip_Down is Down - 1,
    remove_n(Skip_Down, Inputs, Tail),
    
    gen_path([Right, Down], New_Depth, Tail, Result),
    Path = [Value|Result], !.


solution1(Inputs, Result) :- 
    gen_path([3, 1], 0, Inputs, Path),
    counter(Path, #, Result).
    
solution2(Inputs, Result) :-
    Slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]],
    gen_path([1, 1], Inputs, Path1),
    gen_path([3, 1], Inputs, Path2),
    gen_path([5, 1], Inputs, Path3),
    gen_path([7, 1], Inputs, Path4),
    gen_path([1, 2], Inputs, Path5),
    counter(Path1, #, Trees1),
    counter(Path2, #, Trees2),
    counter(Path3, #, Trees3),
    counter(Path4, #, Trees4),
    counter(Path5, #, Trees5),
    Result is Trees1 * Trees2 * Trees3 * Trees4 * Trees5.

    
main :-
    get_puzzle_inputs(Inputs),
    solution1(Inputs, Solution1),
    solution2(Inputs, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).
