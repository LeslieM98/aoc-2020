:- module(day06,[main/3, main/0]).
:- use_module("../input_loader",[get_puzzle_inputs/1, get_puzzle_inputs/2]).
:- use_module("../aoc_util").
:- use_module(library(pcre)).

first_group([""|_], []) :- !.
first_group(List, List) :-
    include(equiv(""), List, []), !.
first_group([E|List], Result) :-
    first_group(List, Acc),
    Result = [E|Acc].


group_answers([], []) :- !.
group_answers([""|List], Result) :- 
    group_answers(List, Result).
group_answers(Input, Result) :-
    first_group(Input, Group),
    append(Group, Rest, Input),
    group_answers(Rest, Acc), !,
    Result = [Group|Acc].

person_isolate_answers(Person, Answers) :-
    string_chars(Person, Answers).

group_unique_answers(Group, Unique_Answers) :-
    maplist(person_isolate_answers, Group, Isolated_Answers),
    flatten(Isolated_Answers, Flat),
    is_list(Flat),
    list_to_set(Flat, Unique_Answers).

group_collective_all_true_questions(Group, Result) :-
    maplist(person_isolate_answers, Group, Isolated_Answers),
    flatten(Isolated_Answers, All_Answers),
    list_to_set(All_Answers, All_Answered_Questions),
    foldl(intersection,Isolated_Answers, All_Answered_Questions, Result).

solution1(Input, Solution) :-
    group_answers(Input, Groups),
    maplist(group_unique_answers, Groups, Unique_Answers),
    maplist(length, Unique_Answers, Lengths),
    sum_list(Lengths, Solution).


solution2(Input, Solution) :-
    group_answers(Input, Groups),
    maplist(group_collective_all_true_questions, Groups, Unique_Answers),
    maplist(length, Unique_Answers, Lengths),
    sum_list(Lengths, Solution).


main(Input, Solution1, Solution2) :-
    solution1(Input, Solution1),
    solution2(Input, Solution2).

main :-
    get_puzzle_inputs("day06/input.txt", Input),
    main(Input, Solution1, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).