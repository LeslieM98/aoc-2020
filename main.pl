:- include("input_loader.pl").
:- use_module("day1/day1", [main/3 as day1]).
:- use_module("day2/day2", [main/3 as day2]).
:- use_module("day3/day3", [main/3 as day3]).


main :-
    get_puzzle_inputs("day1/input.txt", D1_Input),
    day1(D1_Input, D1P1, D1P2),
    writeln(D1P1),
    writeln(D1P2),
    
    get_puzzle_inputs("day2/input.txt", D2_Input),
    day2(D2_Input, D2P1, D2P2),
    writeln(D2P1),
    writeln(D2P2),
    
    get_puzzle_inputs("day3/input.txt", D3_Input),
    day3(D3_Input, D3P1, D3P2),
    writeln(D3P1),
    writeln(D3P2).