/*
    CSINTSY MCO3
    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    DATABASE OF SYMPTOMS
*/

% DYNAMIC FACTS
:- dynamic headache/1.
:- dynamic highTemp/1.
:- dynamic lowTemp/1.
:- dynamic feelingCold/1.
:- dynamic vomiting/1.
:- dynamic nausea/1.
:- dynamic feelsWeak/1.
:- dynamic pale/1.
:- dynamic redSpots/1.
:- dynamic bodyPain/1.
:- dynamic soreMuscles/1.
:- dynamic chestPain/1.
:- dynamic cough/1.
:- dynamic bleeding/1.
:- dynamic weakness/1.
:- dynamic tired/1.
:- dynamic weightLoss/1.
:- dynamic noAppetite/1.
:- dynamic nightSweat/1.
:- dynamic phlegm/1.
:- dynamic shortnessBreath/1.
:- dynamic morningHeadache/1.
:- dynamic badPulse/1.
:- dynamic blurryVision/1.
:- dynamic troubleHearing/1.
:- dynamic cramps/1.
:- dynamic confusion/1.
:- dynamic anxiety/1.
:- dynamic wheezing/1.
:- dynamic mildTemperature/1.
:- dynamic looseStools/1.
:- dynamic abdominalPain/1.
:- dynamic noHydration/1.

% PREDICATES
% P - patient

fever(P) :-
    highTemp(P),
    headache(P).

chills(P) :-
    feelingCold(P).

malaise(P) :-
    feelsWeak(P),
    pale(P).

rash(P) :-
    redSpots(P).

achesPains(P) :-
    bodyPain(P),
    soreMuscles(P).

bloodCough(P) :-
    cough(P),
    bleeding(P).

fatigue(P) :-
    weakness(P),
    tired(P).

irregularHeartRhythms(P) :-
    chestPain(P), %# DOUBLE CHECK THIS
    badPulse(P).

visionChanges(P) :-
    blurryVision(P).

earBuzzing(P) :-
    troubleHearing(P).

muscleTremors(P) :-
    soreMuscles(P),
    cramps(P).

lowFever(P) :-
    headache(P),
    mildTemperature(P).

dehydration(P) :-
    pale(P),
    noHydration(P).