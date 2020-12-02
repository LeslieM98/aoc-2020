:- include("../io_util.pl").

counter([], _, 0). 
counter([E|Es], E, Count) :-
    counter(Es, E, Acc), !, 
    Count is Acc + 1.
counter([_|Es], E, Count) :- counter(Es, E, Count). 
  

valid_password(Input):- 
    string_chars(Input, [Xc, '-', Yc, ' ', C, ':', ' ' | Password]),
    atom_number(Xc, X),
    atom_number(Yc, Y),
    counter(Password, C, Occurances),
    Occurances >= X,
    Occurances =< Y.

solve_part1:- 
    valid_password("1-3 a: abcde").
