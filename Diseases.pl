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
    fever(P),
    headache(P), % follow-up; retro-orbital
    nausea(P),
    rash(P),
    achesPains(P),
    malaise(P).

tuberculosis(P) :-
    fever(P),
    chestPain(P),
    bloodCough(P),
    cough(P), longCough(P), phlegm(P),
    (weakness(P); fatigue(P)),
    weightLoss(P),
    nightSweat(P). % Back pain

pneumonia(P) :-
    fever(P),
    chills(P),
    (cough(P); phlegm(P)),
    shortnessBreath(P), % OR
    chestPain(P).

bronchitis(P) :-
    ((cough(P); phlegm(P)),
    chestPain(P));
    wheezing(P). % ADD OR - shortnessBreath

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

diarrhea(P) :- % Gastroenteritis
    looseStools(P),
    abdominalPain(P),
    dehydration(P).

cholera(P) :-
    diarrhea(P),
    profuseLooseStools(P),
    fasterDehydration(P).

flu(P) :-
    fever(P),
    cough(P),
    cold(P),
    runnyNose(P).