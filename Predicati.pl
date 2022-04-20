%Si vuole definire un predicatogruppiDiLettereUguali(Lista,ListaLettereMultiple)
%che sia vero se Lista è una lista dicaratteri 
%ListaLettereMultiple è la lista di caratteri che sono ripetuti in Lista

lettereRipetute([],[]).
lettereRipetute([H|T],[H|S]):-
    member(H,T),
    lettereRipetute(T,S),
    \+ member(H,S),
    !.

%predicato che definisce una lista con senza le ripetizioni

predicatogruppiDiLettereUguali([],[]).    
predicatogruppiDiLettereUguali([H|T],[H|L]):-
    \+ member(H,T),
    predicatogruppiDiLettereUguali(T,L),
    !.
predicatogruppiDiLettereUguali([_|T],L):-
    predicatogruppiDiLettereUguali(T,L).

%Anagrammi
isAnagramma(levirato,livreato).
isAnagramma(levirato,relativo).
isAnagramma(levirato,rilevato).
isAnagramma(levirato,rivelato).

anagrammed(Parola,ListaAnagrammiParola):-
    setof(X,C^isAnagramma(Parola,X),ListaAnagrammiParola).
%returns the first N elements of L
first_n(L,N,LN):-
    append(LN,_,L),
    length(LN,N).

%rotates L
rotateRight(L,[A|LN]):-
    length(L,N),
    N1 is N - 1,
    first_n(L,N1,LN),
    last_elem(L,A),!.

%returns the last element of a list
last_elem([X|[]],X).
last_elem([_|T],X):-
    last_elem(T,X).

%returns the last element of a list and deletes it
pop_last([E], [], E).
pop_last([H|T], [H|L], E):-
    pop_last(T, L, E).

%retate a list N times
rotateRightN(L,0,L).
rotateRightN(L,N,L2):-
    var(L2),
    rotateRight(L,L3),
    N1 is N - 1,
    rotateRightN(L3,N1,L2),
    !.
rotateRightN(L,N,L2):-
    var(L),
    N1 is N - 1,
    rotateRightN(L3,N1,L2),
    rotateRight(L,L3),
    !.
    

merge_sorted([T],[T]).
merge_sorted([],[]).
merge_sorted(L, LISTA_ORDINATA):-
    length(L,N),
    H1 is N//2,
    H2 is N - H1,
    length(LISTA_SX, H1),
    length(LISTA_DX, H2),
    append(LISTA_SX, LISTA_DX, L),
    merge_sorted(LISTA_SX, LISTA_SX_ORDINATA),
    merge_sorted(LISTA_DX, LISTA_DX_ORDINATA),
    merged(LISTA_SX_ORDINATA, LISTA_DX_ORDINATA, LISTA_ORDINATA),!.

merged([],[],[]).
merged([],L,L).
merged(L,[],L).
merged([H1|T1],[H2|T2],[H1|T]):-
      H1 < H2,
      merged(T1,[H2|T2],T).
merged([H1|T1],[H2|T2],[H2|T]):-
      H1 >= H2,
      merged([H1|T1],T2,T).
%--------------------------------------------------------------------

doubled([],[]).
doubled([H|T],[H,H|L]):-
   double(T,L). 

%data una lista di liste, spacchetta tutto [[1,2,3],4,[5]] -> [1,2,3,4,5]

unpacked([],[]).
unpacked([H|T],L):-
    is_list(H),
    unpacked(H,L1),
    unpacked(T,L2),
    append(L1,L2,L),
    !.
unpacked([H|T],[H|TL]):-
    unpacked(T,TL),!.

%Example:
% compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [a,b,c,a,d,e]

compress([],[]).
compress([H|T],L):-
   member(H,T),
   compress(T,L),!.
compress([H|T],[H|L]):-
    compress(T,L),!.

%--------------------------------------------------------------------



/*lezione 10 06-04*/

genitore(mario, dario).
genitore(pino, dario).

fratelloDi(M,N):-
    genitore(M,K),
	genitore(N,K),
	no_duplicates([M,N],[M,N]).
	
	
ordinata([]).
ordinata([_]).
ordinata([X,Y|L]):-
    X>=Y,
	ordinata([Y|L]).

rivoltata([],[]).

rivoltata([H|T], LR):-
    rivoltata(T,HR),
    appiccicata(HR, [H], LR).

appiccicata([],L,L).
appiccicata(L,[],L).

appiccicata([H|T1], L2, [H|T]):-
    appiccicata(T1, L2, T).
    
appartiene(X, [X|_]).
appartiene(X, [_|L]):-
    appartiene(X, L).

/*quicksort*/
quick_sorted([],[]).

quick_sorted([Pivot|L],LO):-	
    partitioned(L,Pivot,L1,L2),
	quick_sorted(L1,LO1),
	quick_sorted(L2,LO2),
	append(LO1,[Pivot|LO2],LO).
	
/*partitioned(L,Pv,L1,L2)*/

partitioned([],_,[],[]).
partitioned([H|L],Pv,[H|L1],L2):-
    H<Pv,
	partitioned(L,Pv,L1,L2).
	
partitioned([H|L],Pv,L1,[H|L2]):-
    H>=Pv,
	partitioned(L,Pv,L1,L2).
	
/*bubblesort*/

b_sort(L,[M|LO]):-
    max_elem(L,M),
	privata_di(L,M,LP),
	b_sort(LP,LO).
	
bubblesort(List,Sorted):-
    swap(List,List1),!,
	bubblesort(List,Sorted).
	
bubblesort(Sorted,Sorted).
	
swap([X,Y|Rest],[Y,X|Rest]):-
	X@>Y.
	
swap([Z|Rest],[Z|Rest1]):-
    swap(Rest,Rest1).
	
/*tutti_i_risultati_di*/

:- dynamic appoggio/1.
		appoggio([]).

		tutti_risultati_di_a(_):-
    			a(H),
    			write(H), nl,
    			% appoggio = appoggio + [H]
    			appoggio(L),
    	
    			assert(appoggio([H|L])),
    			retract(appoggio(L)),
    
    			fail.

/*no_duplicates*/

no_duplicates([], []).

	no_duplicates([H|L], LND):-
    		member(H,L), !,			% con ! non possiamo scambiare l'ordine delle regole
    		no_duplicates(L,LND).

	%caso in cui non c'è
	no_duplicates([H|L],[H|LND]):-
    		%\+ member(H,L),
    		no_duplicates(L,LND).

/*la lista ha elementi pari*/

pari([]).

pari([_,_|T]):-
    pari(T)

/* PROBLEMA DELLE OTTO REGINE */

% ci sarà una regina per riga
% definiamo le regine con le posizioni (riga, colonna)
% [1/Y1, 2/Y2, ..., 8/Y8]
% idea: la prima non minaccia tutte le altre dopo, la seconda non
% minaccia tutte le altre dopo...5

% costruiamo un predicato che ci da vero se una regina non minaccia le
% regine successive

non_minaccia(_/_,[]).
non_minaccia(X/Y, [X1/Y1|RESTO]):-
    X =\= X1,
    Y =\= Y1,
    Y1-Y =\= X1-X,    % controlla la diagonale
    Y1-Y =\= X-X1,
    non_minaccia(X/Y, RESTO).


soluzione([]).

soluzione([X/Y|RESTO]):-
    member(Y, [1,2,3,4,5,6,7,8]),
    soluzione(RESTO),
    non_minaccia(X/Y, RESTO).

/* AUTOMA CHE RICONOSCE UN LINGUAGGIO L */
/* L = a*b*c   */

tr(1, 1, a).
tr(1,2 ).
tr(1, 2, a).
tr(2, 2, b).
tr(2, 3, c).
finale(c).

appartiene(F, []):- finale(F).

appartiene(Stato, [I|Stringa]):-
    appartiene(S1, Stringa),
    tr(Stato, S1, I).

% not - negazione 

my_not(P):-
    P, !, fail.		

my_not(_).			

% diverso %

diverso(X,X):-
   !, fail.   
			  

diverso(_,_).

% occorrenze %

occorrenze(_,[],0).

occorrenze(X, [X|T], N) :- !, 	% con ! lo conto e basta e taglio il ramo
    occorrenze(X,T,M),
    N is M + 1.

occorrenze(X, [_|T], N):-
    occorrenze(X,T,N).

% elementi diversi da %

elementi_diversi_da(_,[],0).

elementi_diversi_da(X, [X|T], N):-
    elementi_diversi_da(X,T,N).

elementi_diversi_da(X, [_|T], N):-
    elementi_diversi_da(X,T,M), !, % perchÃ¨ ??
    N is M + 1.

% permutazione %

permutazione([],[]).

permutazione([H|T], Y):-
    permutazione(T, YmenoH),      /* messo prima così capisce la lungezza della lista */
    tolto(H, Y, YmenoH).

tolto(X, [X|T], T).

tolto(X, [YH|YT], [YH|YTmenoX]):-
    tolto(X, YT, YTmenoX).

% palindroma %

palindroma([]).
palindroma(L):-
    reverse(L, LR),
    uguale(L,LR).

% uguale %

uguale([],[]).    
uguale([H1|T1], [H1|T1]).

% lunghezza di una lista %

lung([], 0).
lung([_|T], N):-
    lung(T,N1),
    N is N1+1.

% somma %

somma_cifre(0,0,0,0).
somma_cifre(0,1,0,1).
somma_cifre(0,2,0,2).

somma_cifre(1,0,0,1).
somma_cifre(1,1,0,2).
somma_cifre(1,2,1,0).

somma_cifre(2,0,0,2).
somma_cifre(2,1,1,0).
somma_cifre(2,2,1,1).

/* predicato somma(num1, num2, ris) */
somma([], N, N, 0).
somma([], N, N1, 1):-
    somma([1], N, N1, 0).
/* uguali ma con arg scambiati */
somma(N, [], N, 0).
somma(N,[], N1,1):-
    somma(N, [1], N1, 0).


somma([C1|T1],[C2|T2], [C3|T3], R):-
    somma_cifre(C1, C2, NRT, CT),
    somma_cifre(CT, R, NRX, C3),
    somma_cifre(NRT, NRX, _, NR),
    somma(T1, T2, T3, NR).
    


