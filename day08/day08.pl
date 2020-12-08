:- module(day08,[main/3, main/0]).
:- use_module("../input_loader",[get_puzzle_inputs/1, get_puzzle_inputs/2]).
:- use_module("../aoc_util").
:- use_module(library(pcre)).
:- use_module(library(clpfd)).

decode_arg(Arg_Str, Arg) :-
    number_string(Arg, Arg_Str).

execute_op([PtrO, Acc], "nop", _, [PtrN, Acc]) :- 
    PtrN #= PtrO + 1, 
    label([PtrN]), !.
execute_op([PtrO, Acc], "jmp", Arg, [PtrN, Acc]) :- 
    PtrN #= PtrO + Arg,
    label([PtrN]), !.
execute_op([PtrO, AccO], "acc", Arg, [PtrN, AccN]) :-
    AccN #= AccO + Arg,
    PtrN #= PtrO + 1, 
    label([AccN, PtrN]), !.

decode_op(Operation, [Operator, Argument]) :-
    re_split(" ", Operation, [Operator, _, Arg_Str]),
    decode_arg(Arg_Str, Argument).

execute_instr([Code, Ptr, Acc], [Code, PtrN, AccN]) :-
    nth0(Ptr, Code, [Op, Arg]),
    execute_op([Ptr, Acc], Op, Arg, [PtrN, AccN]).


execute_code(Code, [Ptr, Out], _, [Ptr, Out]) :-
    length(Code, Ptr), !.
execute_code(_, [Ptr, Out], Ran_Instructions, [Ptr, Out]) :-
    member(Ptr, Ran_Instructions), !.
execute_code(Code, [Ptr, Acc], Ran_Instructions, [PtrN, AccN]) :-
    append([Ptr], Ran_Instructions, New_Ran_Instructions),
    execute_instr([Code, Ptr, Acc], [Code, PtrTMP, AccTMP]),
    execute_code(Code, [PtrTMP, AccTMP], New_Ran_Instructions, [PtrN, AccN]).

change_op(["nop", Arg], ["jmp", Arg]).
change_op(["jmp", Arg], ["nop", Arg]).



split_at_e(Left, E, Right, List) :-
    append(Left, [E|Right], List).

change_single_op_in_code(Code, Changed) :-
    split_at_e(Left, E, Right, Code),
    change_op(E, C),
    split_at_e(Left, C, Right, Changed).


solution1(Input, Solution) :-
    maplist(decode_op, Input, Decoded),
    execute_code(Decoded, [0, 0], [], [_, Solution]).


solution2(Input, Solution) :-
    maplist(decode_op, Input, Decoded),
    change_single_op_in_code(Decoded, Corrected),
    execute_code(Corrected, [0, 0], [], [Ptr, Solution]),
    length(Input, Ptr).
    


main(Input, Solution1, Solution2) :-
    solution1(Input, Solution1),
    solution2(Input, Solution2), !.

main :-
    get_puzzle_inputs("day08/input.txt", Input),
    main(Input, Solution1, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).