/*
    CSINTSY MCO3
    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    DATABASE OF DISEASES
        - This database requires the database of symptoms to refer to.
*/

% LOAD SYMPTOMS DATABASE
:- consult("Symptoms").

% FACTS

% PREDICATES

malaria(P) :-
    fever(P),
    chills(P),
    headache(P),
    nausea(P),
    vomiting(P),
    malaise(P).

dengue(P) :-
    nausea(P),
    vomiting(P),
    rash(P),
    achesPains(P).

tuberculosis(P) :-
    chestPain(P),
    (bloodCough(P); phlegm(P)),
    (weakness(P); fatigue(P)),
    weightLoss(P),
    noAppetite(P),
    chills(P),
    fever(P),
    nightSweat(P).

pneumonia(P) :-
    fever(P),
    chills(P),
    (cough(P); phlegm(P)),
    shortnessBreath(P),
    chestPain(P),
    (nausea(P); vomiting(P)),
    diarrhea(P).

mildHypertension(P) :-
    morningHeadache(P),
    irregularHeartRhythms(P),
    visionChanges(P),
    earBuzzing(P).

severeHypertension(P) :-
    fatigue(P),
    nausea(P),
    vomiting(P),
    chestPain(P),
    muscleTremors(P),
    confusion(P),
    anxiety(P),
    wheezing(P),
    shortnessBreath(P),
    lowFever(P).

diarrhea(P) :-
    looseStools(P),
    abdominalPain(P),
    dehydration(P).