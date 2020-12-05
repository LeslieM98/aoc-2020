:- module(aoc_util,[list_half_half/3,interval_from_to/3,interval_to/2,zip/3,concat_inputs/2,equiv/2,counter/3,remove_n/3,mul/3,contains/2]).

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

equiv(V1, V2) :- V1 = V2.

concat_inputs(Inputs, Concat) :-
    atomic_list_concat(Inputs, Tmp),
    atom_string(Tmp, Concat).

counter(_, [], 0).
counter(E, [E|Es],  Count) :-
    counter(E, Es, Acc), !,
    Count is Acc + 1.
counter(E, [_|Es], Count) :- counter(E, Es, Count).

remove_n(0, In, In) :- !.
remove_n(_, [], []) :- !.
remove_n(N, [_|Ins], Out) :-
    New_N is N - 1,
    remove_n(New_N, Ins, Out).

mul(V1, V2, R) :- R is V1*V2.

contains(E, [E|_]).
contains(C, [_|Es]) :- contains(C, Es).
