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
