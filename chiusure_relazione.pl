/* Programma Prolog per calcolare le chiusure di una relazione */

main :- write('Inserisci l\'insieme di numeri naturali tra parentesi quadre: '), nl,
        read(I),
        sort(I, IU),
        format('Insieme privo di duplicati: ~w~n', [IU]),
        acquisisci_relazione(IU, R),
        format('Relazione priva di duplicati: ~w~n', [R]),
        riflessiva(R, CR),
        format('Chiusura riflessiva di R: ~w~n', [CR]),
        simmetrica(R, CS),
        format('Chiusura simmetrica di R: ~w~n', [CS]),
        transitiva(R, CT),
        format('Chiusura transitiva di R: ~w~n', [CT]).

/* Il predicato acquisisci_relazione acquisisce la relazione da tastiera, 
   verifica che sia valida sull'insieme e la restituisce priva di eventuali duplicati:
   -il primo argomento è l'insieme sul quale la relazione deve essere valida
   .il secondo argomento è la relazione, priva di duplicati. */

acquisisci_relazione(I, RU) :- write('Inserisci la relazione come lista di coppie (es [(1,2),(2,3)]): '), nl,
                               read(R),
                               sort(R, RU),
                               ( relazione_valida(RU, I)
                               -> true
                               ; write('Errore: alcune coppie contengono elementi non presenti nell\'insieme.'), nl,
                                   acquisisci_relazione(I, RU)
                               ).

/* Il predicato relazione_valida verifica che la relazione sia valida sull'insieme inserito:
   -il primo argomento è la relazione
   -il secondo argomento è l'insieme. */

relazione_valida([], _I).
relazione_valida([(A,B)|T], I) :- member(A, I), member(B, I), relazione_valida(T, I).


/* il predicato riflessiva calcola la chiusura riflessiva di una relazione:
   -il primo argomento è la relazione
   -il secondo argomento è la chiusura riflessiva. */

riflessiva([], []).
riflessiva(R, CR) :- findall((X,X), (member((A,B), R), (X=A; X=B)), CPR),
                     append(R, CPR, Temp), sort(Temp, CR).

/* il predicato simmetrica calcola la chiusura simmetrica di una relazione, 
   -il primo argomento è la relazione
   -il secondo argomento è la chiusura simmetrica.*/

simmetrica([], []).
simmetrica(R, CS) :- findall((B,A), (member((A,B), R), \+ member((B,A), R)), CPS),
                     append(R, CPS, Temp), sort(Temp, CS).

/* il predicato transitiva calcola la chiusura transitiva di una relazione:
   -il primo argomento è la relazione
   -il secondo argomento è la chiusura transitiva.*/

transitiva([], []).
transitiva(R, CT) :- findall((A,D), (member((A,B), R), member((B,D), R), \+ member((A,D), R)), Nuove),
                     (Nuove = [] ->  CT = R ; append(R, Nuove, Temp), sort(Temp, TempOrd), transitiva(TempOrd, CT)).

