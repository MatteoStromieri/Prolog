%cammino su grafo tra i nodi P1 e P2

e(a,b).
e(a,z).
e(z,d).
e(b,c).
e(c,d).

cammino(P1,P2,[]):-
    e(P1,P2).
cammino(P1,P2,[X|Catena]):-
    e(P1,X),
    cammino(X,P2,Catena).

%descrivere il cammino minimo
:- dynamic walk/1.

camminoMinimoInterfaccia(P1,P2,Y):-
    cammino(P1,P2,C),
    !,
    assert(walk(C)),
    \+ camminoMinimo(P1,P2),
    walk(Y),
    retract(walk(Y)).

camminoMinimo(P1,P2):-
    walk(X),
    cammino(P1,P2,C),
    length(C,Nc),
    length(X,Nx),
    Nx > Nc,
    assert(walk(C)),
    retract(walk(X)),
    fail.
