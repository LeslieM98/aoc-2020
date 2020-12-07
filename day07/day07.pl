:- module(day07,[main/3, main/0]).
:- use_module("../input_loader",[get_puzzle_inputs/1, get_puzzle_inputs/2]).
:- use_module("../aoc_util").
:- use_module(library(pcre)).

extract_colours_bagcount_bagstrings([], []).
extract_colours_bagcount_bagstrings([Bagstring| Bagstrings], Extracted) :-
    re_split(" ", Bagstring, Split),
    exclude(equiv(" "), Split, [Count, Col1, Col2|_]),
    number_string(Count_Int, Count),    
    extract_colours_bagcount_bagstrings(Bagstrings, Acc),
    foldl(string_concat, [Col2, " ", Col1], "", Colour),
    Extracted = [[Colour, Count_Int]|Acc].    

parse_contained("no other bags.", []) :- !.
parse_contained(Input, Contained) :-
    re_split("(, |\\.)", Input, Split_At_Comma),
    exclude(equiv(", "), Split_At_Comma, Split_No_Comma),
    exclude(equiv("."), Split_No_Comma, Split_No_Dot),
    exclude(equiv(""), Split_No_Dot, Bagstrings),
    extract_colours_bagcount_bagstrings(Bagstrings, Contained).


parse_line(Input, [Container, Parsed_Contained]) :- 
    re_split(" bags contain ", Input, [Container, _, Contained]),
    parse_contained(Contained, Parsed_Contained).

get_container_contained([], _, []) :- !.
get_container_contained([[Container, Contained]| _], Container, Contained) :- !.
get_container_contained([_| Rest], Container, Contained) :-
    get_container_contained(Rest, Container, Contained).


can_contain_gold(_, [["shiny gold", _]|_]) :- !.
can_contain_gold(Parsed_Input, [[Colour, _]|List_Of_Contained]) :-
    get_container_contained(Parsed_Input, Colour, Next_Layer),
    append(Next_Layer, List_Of_Contained, Queue),
    can_contain_gold(Parsed_Input, Queue).

get_contained_from_node([_, Contained], Contained).

    
    
    
    

    

parse_data(Input, Parsed_Tree) :-
    maplist(parse_line, Input, Parsed_Tree).

    

solution1(Input, Solution) :-
    parse_data(Input, Parsed),
    maplist(get_contained_from_node, Parsed, Containeds),
    include(can_contain_gold(Parsed), Containeds, Can_Contain_Gold),
    length(Can_Contain_Gold, Solution).

test :- 
    get_puzzle_inputs("day07/input.txt", Input),
    parse_data(Input, Parsed),
    can_contain_gold(Parsed, [["light red",1]]),
    can_contain_gold(Parsed, [["dark orange",1]]),
    can_contain_gold(Parsed, [["bright white",1]]),
    can_contain_gold(Parsed, [["muted yellow",1]]).

solution2(_Input, Solution) :-
    Solution = "NOT DONE YET".


main(Input, Solution1, Solution2) :-
    solution1(Input, Solution1),
    solution2(Input, Solution2).

main :-
    get_puzzle_inputs("day07/input.txt", Input),
    main(Input, Solution1, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).