/*
    CSINTSY MCO3
    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    MAIN PROGRAM HANDLER
*/
% Load the diseases knowledge base
:- consult("Diseases").

% Predicate to Start PROGRAM - ENGLISH
startENSession :-
    write_ln("Barangay Level of Common Rural Diseases."),
    write_ln("We will be asking you a series of questions regarding your symptoms to establish an idea of possible illnesses."),

    % Always ask for consent
    write("Would you like to proceed? [Y/N]: "), read(Consent),
    (Consent = 'Y' ; Consent = 'y'),

    % Proceed for positive consent
    nl, nl, nl,

    % Greet User
    write("Please enter your name: "), read(PatientName), nl,
    write("Good day, "), write(PatientName), nl, nl.

    