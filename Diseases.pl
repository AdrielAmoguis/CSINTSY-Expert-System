/*
    CSINTSY MCO3

    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    Database of Diseases
*/

% Import the Symptoms Database
:- consult("Symptoms.pl").

/* DISEASE DEFINITIONS - Weighted Symptoms */

% Malaria
malaria(P, C) :-
    L = [],
    ((fever(P) -> append([30], L, L1); not(fever(P)) -> append([], L, L1)) ; true), !,
    ((chills(P) -> append([20], L1, L2); not(chills(P)) -> append([], L1, L2)) ; true), !,
    ((headache(P) -> append([15], L2, L3); not(headache(P)) -> append([], L2, L3)) ; true), !,
    ((nausea(P) -> append([5], L3, L4); not(nausea(P)) -> append([], L3, L4)) ; true), !,
    ((vomiting(P) -> append([5], L4, L5); not(vomiting(P)) -> append([], L4, L5)) ; true), !,
    ((malaise(P) -> append([5], L5, L6); not(malaise(P)) -> append([], L5, L6)) ; true), !,
    ((malariaRiskArea(P) -> append([20], L6, L7); not(malariaRiskArea(P)) -> append([], L6, L7)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L7, C).

% Flu
flu(P, C) :-
    L = [],
    ((fever(P) -> append([50], L, L1); not(fever(P)) -> append([], L, L1))),
    ((cough(P) -> append([10], L1, L2); not(cough(P)) -> append([], L1, L2))),
    ((cold(P) -> append([20], L2, L3); not(cold(P)) -> append([], L2, L3))),
    ((runnyNose(P) -> append([20], L3, L4); not(runnyNose(P)) -> append([], L3, L4))),

    % Calculate & Return the Certainty Factor
    listSum(L4, C).

% Dengue
dengue(P, C) :-
    L = [],
    ((fever(P) -> append([50], L, L1); not(fever(P)) -> append([], L, L1)) ; true), !,
    ((headache(P) -> append([30], L1, L2); not(headache(P)) -> append([], L1, L2)) ; true), !,
    ((rash(P) -> append([10], L2, L3); not(rash(P)) -> append([], L2, L3)) ; true), !,
    ((malaise(P) -> append([10], L3, L4); not(malaise(P)) -> append([], L3, L4)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L4, C).

% Tuberculosis
tuberculosis(P, C) :-
    L = [],
    ((longCough(P) -> append([50], L, L1); not(longCough(P)) -> append([], L, L1)) ; true), !,
    ((chestPain(P) -> append([5], L1, L2); not(chestPain(P)) -> append([], L1, L2)) ; true), !,
    ((bloodCough(P) -> append([45], L2, L3); not(bloodCough(P)) -> append([], L2, L3)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L3, C).

% Pneumonia
pneumonia(P, C) :-
    L = [],
    ((cough(P) -> append([40], L, L1); not(cough(P)) -> append([], L, L1)) ; true), !,
    ((phlegm(P) -> append([10], L1, L2); not(phlegm(P)) -> append([], L1, L2)) ; true), !,
    ((chestPain(P) -> append([5], L2, L3); not(chestPain(P)) -> append([], L2, L3)) ; true), !,
    ((shortnessBreath(P) -> append([30], L3, L4); not(shortnessBreath(P)) -> append([], L3, L4)) ; true), !,
    ((fever(P) -> append([15], L4, L5); not(fever(P)) -> append([], L4, L5)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L5, C).

% Bronchitis
bronchitis(P, C) :-
    L = [],
    ((cough(P) -> append([50], L, L1); not(cough(P)) -> append([], L, L1)) ; true), !,
    ((chestPain(P) -> append([10], L1, L2); not(chestPain(P)) -> append([], L1, L2)) ; true), !,
    ((wheezing(P) -> append([40], L2, L3); not(wheezing(P)) -> append([], L2, L3)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L3, C).

% Diarrhea
diarrhea(P, C) :-
    L = [],
    ((looseStools(P) -> append([70], L, L1); not(looseStools(P)) -> append([], L, L1)) ; true), !,
    ((abdominalPain(P) -> append([20], L1, L2); not(abdominalPain(P)) -> append([], L1, L2)) ; true), !,
    ((dehydration(P) -> append([10], L2, L3); not(dehydration(P)) -> append([], L2, L3)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L3, C).

% Cholera
cholera(P, C) :-
    L = [],
    (((diarrhea(P, DC), DC >= 75) -> append([34], L, L1); not(diarrhea(P, DDC), DDC >= 75) -> append([], L, L1)) ; true), !,
    ((fasterStools(P) -> append([33], L1, L2); not(fasterStools(P)) -> append([], L1, L2)) ; true), !,
    ((fasterDehydration(P) -> append([33], L2, L3); not(fasterDehydration(P)) -> append([], L2, L3)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L3, C).

% Hypertension
hypertension(P, C) :-
    L = [],
    ((highBP(P) -> append([70], L, L1); not(highBP(P)) -> append([], L, L1)) ; true), !,
    ((headache(P) -> append([20], L1, L2); not(headache(P)) -> append([], L1, L2)) ; true), !,
    ((visionChanges(P) -> append([10], L2, L3); not(visionChanges(P)) -> append([], L2, L3)) ; true), !,
    ((obese(P) -> append([10], L3, L4); not(obese(P)) -> append([], L3, L4)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L4, C).

% Diabetes
diabetes(P, C) :-
    L = [],
    ((increasedUrine(P) -> append([25], L, L1); not(increasedUrine(P)) -> append([], L, L1)) ; true), !,
    ((increasedThirst(P) -> append([25], L1, L2); not(increasedThirst(P)) -> append([], L1, L2)) ; true), !,
    ((weightLoss(P) -> append([25], L2, L3); not(weightLoss(P)) -> append([], L2, L3)) ; true), !,
    ((diabetesFamily(P) -> append([25], L3, L4); not(diabetesFamily(P)) -> append([], L3, L4)) ; true), !,

    % Calculate & Return the Certainty Factor
    listSum(L4, C).

/* UTILITY PREDICATES */

% This predicate gets the sum of all elements of a number list.
listSum([], 0).
listSum([E|L], Sum) :-
    listSum(L, S),
    Sum is S + E.

/* OLD PREDICATES
% This predicate gets the sum of all elements of a number list.
listSum([X], X).
listSum([E|L], Sum) :-
    listSum(L, S),
    Sum is S + E.
*/