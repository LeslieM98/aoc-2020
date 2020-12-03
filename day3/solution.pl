:- include("../aoc_util.pl").
:- use_module(library(clpfd)).

gen_path(Inputs, Slope, Path) :- gen_path(Slope, 0, Inputs, Path).

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
    gen_path(Inputs, [3,1], Path),
    counter(#, Path, Result).
    
solution2(Inputs, Result) :-
    Slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]],
    maplist(gen_path(Inputs), Slopes, Paths),
    maplist(counter(#), Paths, Tree_Counts),
    foldl(mul, Tree_Counts, 1, Result).
    
main :-
    get_puzzle_inputs(Inputs),
    solution1(Inputs, Solution1),
    write("Part1: "), writeln(Solution1),
    solution2(Inputs, Solution2),
    write("Part2: "), writeln(Solution2).
