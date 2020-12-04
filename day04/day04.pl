:- module(day04,[main/3, main/0]).
:- use_module("../input_loader",[get_puzzle_inputs/1]).
:- use_module("../aoc_util").
:- use_module(library(pcre)).
% :- use_module(library(clpfd)).
equiv(V1, V2) :- V1 = V2.

concat_inputs(Inputs, Concat) :-
    atomic_list_concat(Inputs, Tmp),
    atom_string(Tmp, Concat).

empty_to_nl(X, Y) :-
    X = "",
    Y = "\n", !.
empty_to_nl(X, X).

add_nl(X, Y) :-
    string_chars(X, C),
    reverse(C, R),
    reverse(['\n'|R], CF),
    string_chars(Y, CF).

get_starts_with([], _, []) :- !.
get_starts_with([E|_], Starts_With, Solution) :-
    re_split(':', E, Split),
    Split = [Starts_With, _, Val|_],
    Solution = [Starts_With, Val], !.
get_starts_with([_|List], Starts_With, Solution) :- get_starts_with(List, Starts_With, Solution).



str_passports(Str, Passports) :-
    re_split('\n\n', Str, Tmp),
    exclude(equiv("\n\n"), Tmp, Passports).

extract(Passport, Field, Value) :-
    re_split('(\n| )', Passport, Fields),
    exclude(equiv("\n"), Fields, Without_NL),
    exclude(equiv(" "), Without_NL, Without_Spaces),
    get_starts_with(Without_Spaces, Field, [_, Value]).

is_valid_Passport(Passport) :- 
    extract(Passport, "byr", _),
    extract(Passport, "iyr", _),
    extract(Passport, "eyr", _),
    extract(Passport, "hgt", _),
    extract(Passport, "hcl", _),
    extract(Passport, "ecl", _),
    extract(Passport, "pid", _).


valid_byr(Val) :-
    number_string(Int, Val),
    Int >= 1920,
    Int =< 2002.

valid_iyr(Val) :-
    number_string(Int, Val),
    Int >= 2010,
    Int =< 2020.

valid_eyr(Val) :-
    number_string(Int, Val),
    Int >= 2020,
    Int =< 2030.

valid_m(['c', 'm'], Val) :-
    Val >= 150,
    Val =< 193.
valid_m(['i', 'n'], Val) :-
    Val >= 59,
    Val =< 76.

valid_hgt(Val) :-
    string_chars(Val, Chars),
    reverse(Chars, CharsR),
    CharsR = [M1, M2|CharHgtR],
    reverse(CharHgtR, CharHgt),
    string_chars(CharHgtStr, CharHgt),
    number_string(CharHgtInt, CharHgtStr),
    valid_m([M2, M1], CharHgtInt).

valid_hcl(Val) :-
    re_match("^#([0-9]|[a-f]){6,6}$", Val). % #623a2f

valid_ecl("amb").
valid_ecl("blu").
valid_ecl("brn").
valid_ecl("gry").
valid_ecl("grn").
valid_ecl("hzl").
valid_ecl("oth").

valid_pid(Val) :-
    number_string(_, Val),
    string_chars(Val, C),
    length(C, 9).

valid_values(Passport) :-
    extract(Passport, "byr", Byr),
    extract(Passport, "iyr", Iyr),
    extract(Passport, "eyr", Eyr),
    extract(Passport, "hgt", Hgt),
    extract(Passport, "hcl", Hcl),
    extract(Passport, "ecl", Ecl),
    extract(Passport, "pid", Pid),

    valid_byr(Byr),
    valid_iyr(Iyr),
    valid_eyr(Eyr),
    valid_hgt(Hgt),
    valid_hcl(Hcl),
    valid_ecl(Ecl),
    valid_pid(Pid).



solution1(Input, Solution) :-
    maplist(empty_to_nl, Input, Spaced),
    maplist(add_nl, Spaced, NLed),
    concat_inputs(NLed, Input_Str),
    str_passports(Input_Str, Passports),
    include(is_valid_Passport, Passports, Valid),
    length(Valid, Solution).

solution2(Input, Solution) :-
    maplist(empty_to_nl, Input, Spaced),
    maplist(add_nl, Spaced, NLed),
    concat_inputs(NLed, Input_Str),
    str_passports(Input_Str, Passports),
    include(valid_values, Passports, Valid),
    length(Valid, Solution).


main(Input, Solution1, Solution2) :-
    solution1(Input, Solution1),
    solution2(Input, Solution2).

% 174 zu niedrig
main :-
    get_puzzle_inputs(Input),
    main(Input, Solution1, Solution2),
    write("Part1: "), writeln(Solution1),
    write("Part2: "), writeln(Solution2).