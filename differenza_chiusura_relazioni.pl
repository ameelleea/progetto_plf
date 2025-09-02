% differenza tra due relazioni
diff([], _, []).
diff([X|Xs], Y, R) :-
    member(X, Y), !,
    diff(Xs, Y, R).
diff([X|Xs], Y, [X|R]) :-
    diff(Xs, Y, R).

% chiusura riflessiva: aggiunge (X,X) per ogni X dell’insieme
riflessiva([], R, R).
riflessiva([X|Xs], R, RR) :-
    (member((X,X), R) -> R1 = R ; R1 = [(X,X)|R]),
    riflessiva(Xs, R1, RR).

% chiusura simmetrica
simmetrica([], R, R).
simmetrica([(A,B)|Xs], R, RR) :-
    (member((B,A), R) -> R1 = R ; R1 = [(B,A)|R]),
    simmetrica(Xs, R1, RR).

% main di esempio
run :-
    writeln('Inserisci l\'insieme (lista es. [1,2,3]).'),
    read(Insieme),
    writeln('Inserisci la prima relazione (es. [(1,2),(2,3)]).'),
    read(R1),
    writeln('Inserisci la seconda relazione (es. [(2,3),(3,1)]).'),
    read(R2),

    diff(R1, R2, DR1),
    writeln('Differenza R1 \\ R2:'), writeln(DR1),

    diff(R2, R1, DR2),
    writeln('Differenza R2 \\ R1:'), writeln(DR2),

    riflessiva(Insieme, R1, Rif),
    writeln('Chiusura riflessiva di R1:'), writeln(Rif),

    simmetrica(R2, R2, Sim),
    writeln('Chiusura simmetrica di R2:'), writeln(Sim).