/*
    CSINTSY MCO3
    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    DATABASE OF SYMPTOMS
*/

% DYNAMIC FACTS

% NEW
% HPI Questions
:- dynamic temperature/2.
:- dynamic bloodPressure/3.
:- dynamic height/2.
:- dynamic weight/2.

% PHYSICAL
:- dynamic pale/1.
:- dynamic redSpots/1.
:- dynamic badPulse/1.

% COMPLAINTS
:- dynamic malaise/1.
:- dynamic headache/1.
:- dynamic runnyNose/1.
:- dynamic cold/1.
:- dynamic rash/1.
:- dynamic chills/1.
:- dynamic vomiting/1.
:- dynamic nausea/1.
:- dynamic chestPain/1.
:- dynamic cough/1.
:- dynamic phlegm/1.
:- dynamic shortnessBreath/1.
:- dynamic blurryVision/1. 
:- dynamic looseStools/1.
:- dynamic abdominalPain/1.
:- dynamic increasedUrine/1.
:- dynamic increasedThirst/1.
:- dynamic weightLoss/1.
:- dynamic dehydration/1.

% Follow-Up
:- dynamic longCough/1.
:- dynamic wheezing/1.
:- dynamic bloodCough/1.
:- dynamic fasterStools/1.
:- dynamic fasterDehydration/1.
:- dynamic diabetesFamily/1.
:- dynamic malariaRiskArea/1.


% PREDICATES
% P - patient

highBP(P) :-
    bloodPressure(P, Diastolic, Systolic),
    Diastolic > 89, Systolic > 120.

highTemp(P) :-
    temperature(P, Temp),
    (Temp >= 37.5).

mildTemperature(P) :-
    temperature(P, Temp),
    (Temp >= 37),
    (Temp < 37.5).

fever(P) :-
    highTemp(P).

visionChanges(P) :-
    blurryVision(P).

obese(P) :-
    getBMI(P, BMI),
    BMI >= 30.

getBMI(P, BMI) :-
    height(P, Height),
    weight(P, Weight),

    % Convert height to meters squared
    mHeight is div(Height, 100),
    msHeight is mHeight**2,
    BMI is div(Weight, msHeight).