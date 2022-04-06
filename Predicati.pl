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
	ordinata(L).

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
    


