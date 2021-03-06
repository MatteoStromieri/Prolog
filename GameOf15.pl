%'Blank' is in the middle
move([R11,R12,R13,R21,'Blank',R23,R31,R32,R33],[R11,R12,R13,'Blank',R21,R23,R31,R32,R33]).
move([R11,R12,R13,R21,'Blank',R23,R31,R32,R33],[R11,'Blank',R13,R21,R12,R23,R31,R32,R33]).
move([R11,R12,R13,R21,'Blank',R23,R31,R32,R33],[R11,R12,R13,R21,R23,'Blank',R31,R32,R33]).
move([R11,R12,R13,R21,'Blank',R23,R31,R32,R33],[R11,R12,R13,R21,R32,R23,R31,'Blank',R33]).

%blank is in R13
move([R11,R12,'Blank',R21,R22,R23,R31,R32,R33],[R11,'Blank',R12,R21,R22,R23,R31,R32,R33]).
move([R11,R12,'Blank',R21,R22,R23,R31,R32,R33],[R11,R12,R23,R21,R22,'Blank',R31,R32,R33]).
%blank is in R11
move(['Blank',R12,R13,R21,R22,R23,R31,R32,R33],[R12,'Blank',R13,R21,R22,R23,R31,R32,R33]).
move(['Blank',R12,R13,R21,R22,R23,R31,R32,R33],[R21,R12,R13,'Blank',R22,R23,R31,R32,R33]).
%blank is in R31
move([R11,R12,R13,R21,R22,R23,'Blank',R32,R33],[R11,R12,R13,'Blank',R22,R23,R21,R32,R33]).
move([R11,R12,R13,R21,R22,R23,'Blank',R32,R33],[R11,R12,R13,R21,R22,R23,R32,'Blank',R33]).
%blank is in R33
move([R11,R12,R13,R21,R22,R23,R31,R32,'Blank'],[R11,R12,R13,R21,R22,'Blank',R31,R32,R23]).
move([R11,R12,R13,R21,R22,R23,R31,R32,'Blank'],[R11,R12,R13,R21,R22,R23,R31,'Blank',R32]).

%blank is in R12
move([R11,'Blank',R13,R21,R22,R23,R31,R32,R33],['Blank',R11,R13,R21,R22,R23,R31,R32,R33]).
move([R11,'Blank',R13,R21,R22,R23,R31,R32,R33],[R11,R22,R13,R21,'Blank',R23,R31,R32,R33]).
move([R11,'Blank',R13,R21,R22,R23,R31,R32,R33],[R11,R13,'Blank',R21,R22,R23,R31,R32,R33]).
%blank is in R21
move([R11,R12,R13,'Blank',R22,R23,R31,R32,R33],['Blank',R12,R13,R11,R22,R23,R31,R32,R33]).
move([R11,R12,R13,'Blank',R22,R23,R31,R32,R33],[R11,R12,R13,R22,'Blank',R23,R31,R32,R33]).
move([R11,R12,R13,'Blank',R22,R23,R31,R32,R33],[R11,R12,R13,R31,R22,R23,'Blank',R32,R33]).
%blank is in R23
move([R11,R12,R13,R21,R22,'Blank',R31,R32,R33],[R11,R12,'Blank',R21,R22,R13,R31,R32,R33]).
move([R11,R12,R13,R21,R22,'Blank',R31,R32,R33],[R11,R12,R13,R21,'Blank',R22,R31,R32,R33]).
move([R11,R12,R13,R21,R22,'Blank',R31,R32,R33],[R11,R12,R13,R21,R22,R33,R31,R32,'Blank']).
%blank is in R32
move([R11,R12,R13,R21,R22,R23,R31,'Blank',R33],[R11,R12,R13,R21,R22,R23,'Blank',R31,R33]).
move([R11,R12,R13,R21,R22,R23,R31,'Blank',R33],[R11,R12,R13,R21,'Blank',R23,R31,R22,R33]).
move([R11,R12,R13,R21,R22,R23,R31,'Blank',R33],[R11,R12,R13,R21,R22,R23,R31,R33,'Blank']).

walk(C1,C2,_):-
    move(C1,C2).
walk(C1,C2,L,X):-
   move(C1,X),
   \+ member(X,L), 
   walk(X,C2,[X|L]).
