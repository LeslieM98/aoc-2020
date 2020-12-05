:- module(day05,[main/3, main/0]).
:- use_module("../input_loader",[get_puzzle_inputs/1, get_puzzle_inputs/2]).
:- use_module("../aoc_util").
:- use_module(library(clpfd)).





zip([], [], []).
zip([E1|L1], [E2|L2], Result) :- 
    zip(L1, L2, Acc),
    Result = [[E1, E2]|Acc].

interval_to(To, Result) :- interval_from_to(0, To, Result).

interval_from_to(To, To, []) :- !.
interval_from_to(From, To, Result) :-
    From_New is From + 1,
    interval_from_to(From_New, To, Acc),
    Result = [From|Acc].

list_half_half(List, Lower, Upper) :-
    length(List, N),
    H is N - N // 2,
    length(Lower, H),
    append(Lower, Upper, List).


split_row_col(Input, Row_Splits, Col_Splits) :-
    string_chars(Input, Input_Chars),
    append(Row_Splits, Col_Splits, Input_Chars),
    length(Row_Splits, 7),
    length(Col_Splits, 3), 
    !,  true.

get_row(Input, Row) :- split_row_col(Input, Row, _).
get_col(Input, Col) :- split_row_col(Input, _, Col).

step_regions(Seats, [], Seats) :- !.
step_regions(Seats, ['L'|Splits], Result) :- 
    step_regions(Seats, ['F'|Splits], Result).
step_regions(Seats, ['R'|Splits], Result) :- 
    step_regions(Seats, ['B'|Splits], Result).
step_regions(Seats, ['F'|Splits], Result) :-
    list_half_half(Seats, Lower, _),
    step_regions(Lower, Splits, Result).
step_regions(Seats, ['B'|Splits], Result) :-
    list_half_half(Seats, _, Upper),
    step_regions(Upper, Splits, Result).

step_cols(Splits, Result) :- 
    interval_to(8, Interval),
    step_regions(Interval, Splits, Result).

step_rows(Splits, Result) :- 
    interval_to(128, Interval),
    step_regions(Interval, Splits, Result).

calculate_seat_id([Row, Col], ID) :-
    ID is Row * 8 + Col.


solution1(Input, Solution) :-
    maplist(get_row, Input, Ticket_Row_Steps),
    maplist(step_rows, Ticket_Row_Steps, Ticket_Rows),

    maplist(get_col, Input, Ticket_Col_Steps),
    maplist(step_cols, Ticket_Col_Steps, Ticket_Cols),

    zip(Ticket_Rows, Ticket_Cols, Ticket_Rows_Cols),

    maplist(calculate_seat_id, Ticket_Rows_Cols, Ticked_Seat_IDs), !,
    max_list(Ticked_Seat_IDs, Solution).

    

solution2(Input, Solution) :-
    Solution = "NOT DONE".


main(Input, Solution1, Solution2) :-
    solution1(Input, Solution1),
    solution2(Input, Solution2).

main :-
    get_puzzle_inputs("day05/input.txt", Input),
    main(Input, Solution1, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).