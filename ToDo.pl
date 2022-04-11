%Example:
%?- pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

appoggio([]).
packed([X,Y|[]]):-
    X == Y
    appoggio(Z),
    append(Z,[X,Y],L2),
    assert(appoggio(L2),
    retract(appoggio(Z)).

packed([X,Y|[]]):-
    appoggio(Z),
    append(Z,[X],L2),
    assert(appoggio(L2),
    retract(appoggio(Z)).


packed([X,Y|T]):-
    X == Y,
    appoggio(Z),
    append(Z,[X],L2),
    assert(appoggio(L2)),
    retract(appoggio(Z)),
    packed([Y|T]).

packed([X,Y|T]):-
    appoggio(Z),
    append(Z,[X],L2),
    assert(appoggio(L2),
    retract(appoggio(Z)),
    packed([Y|T]).
