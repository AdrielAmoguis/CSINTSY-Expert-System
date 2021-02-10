:- dynamic cough/1.
:- dynamic chestPain/1.
:- dynamic wheezing/1.

:- dynamic diagnosis/3.

% Bronchitis
bronchitis(P, C) :-
    L = [],
    ((cough(P) -> append([50], L, L1); not(cough(P)) -> append([], L, L1)) ; true), !,
    ((chestPain(P) -> append([10], L1, L2); not(chestPain(P)) -> append([], L1, L2)) ; true), !,
    ((wheezing(P) -> append([40], L2, L3); not(wheezing(P)) -> append([], L2, L3)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L3, C).

% This predicate gets the sum of all elements of a number list.
listSum([], 0).
listSum([E|L], Sum) :-
    listSum(L, S),
    Sum is S + E.

testDecision :-
    write_ln("Enter a decision [Y/N]"),
    read(Decision),
    (Decision = 'Y' ; Decision = 'y').

% Get top diagnosis
getTopDiagnosis(P, Disease) :-
    listDiseases(P, DiseaseList),
    listMax(DiseaseList, Disease), !.

% Get the maximum in the disease list
listMax([X],X) :- !, true.
listMax([[_|C]|R], [Mn|Mc]) :- 
    listMax(R, [Mn|Mc]), Mc >= C.
listMax([[N|C]|R], [N|C]) :- 
    listMax(R, [_|Mc]),
    C > Mc.

% Get the disease list
listDiseases(P, []) :- not(diagnosis(P,_,_)), !.
listDiseases(P, [Disease | Tail]) :-
    retract(diagnosis(P, D, C)), !,
    Disease = [D,C],
    listDiseases(P, Tail), !.