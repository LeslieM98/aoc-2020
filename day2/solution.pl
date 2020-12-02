:- include("../io_util.pl").
:- use_module(library(pcre)).

counter([], _, 0).
counter([E|Es], E, Count) :-
    counter(Es, E, Acc), !,
    Count is Acc + 1.
counter([_|Es], E, Count) :- counter(Es, E, Count).

extract_values_from_definition(Definition, Min, Max, Char, Password) :-
    re_split('-', Definition, Split1),
    Split1 = [Minc, _, No_Min],
    re_split(' ', No_Min, Split2),
    Split2 = [Maxc, _, Char_Weird, _, Password_Str],
    string_chars(Password_Str, Password),
    number_string(Min, Minc),
    number_string(Max, Maxc),
    string_chars(Char_Weird, [Char, ':']).


valid_password(Input):-
    extract_values_from_definition(Input, X, Y, C, Password),
    counter(Password, C, Occurances),
    Occurances >= X,
    Occurances =< Y.

solve_part1:-
    get_puzzle_inputs(Inputs),
    exclude(valid_password, Inputs, Valid_Passwords),
    length(Valid_Passwords, Count),
    writeln(Count).
