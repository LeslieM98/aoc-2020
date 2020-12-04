:- use_module("input_loader", [get_puzzle_inputs/2]).
:- use_module("day01/day01", [main/3 as day01]).
:- use_module("day02/day02", [main/3 as day02]).
:- use_module("day03/day03", [main/3 as day03]).


main :-
    get_puzzle_inputs("day01/input.txt", D1_Input),
    day01(D1_Input, D1P1, D1P2),
    writeln(D1P1),
    writeln(D1P2),
    
    get_puzzle_inputs("day02/input.txt", D2_Input),
    day02(D2_Input, D2P1, D2P2),
    writeln(D2P1),
    writeln(D2P2),
    
    get_puzzle_inputs("day03/input.txt", D3_Input),
    day03(D3_Input, D3P1, D3P2),
    writeln(D3P1),
    writeln(D3P2).