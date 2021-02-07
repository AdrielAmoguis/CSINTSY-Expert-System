/*
    CSINTSY - MCO3

    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.
*/

% Import the Diseases Module
:- consult("Diseases.pl").

/* MAIN SESSION HANDLER */
diagnose(PatientName) :-

    % Greet Patient
    format("Good day, ~w!~n~n", [PatientName]),

    % Display Program Details
    write_ln("Medical Diagnostc System: Developed by AMOGUIS & SUN."),
    write_ln("College of Computer Studies, De La Salle University\n"),

    % Display Confidentaility Clause
    write_ln("The data collected from you during this session is for diagnostic purposes only and shall only be stored throughout this session."),
    write_ln("We will be asking you a series of questions regarding your symptoms to establish an idea of possible illnesses.\n"),

    % Get User Consent
    write("Would you like to proceed? [Y/N]: "), read(Consent),
    (Consent = 'Y' ; Consent = 'y'),
    nl, nl, nl,

    % Prompt User of the Questionnaire
    write_ln("\nWe will now begin with the questionnaire.\n"),

    % Get User Consent
    write("Would you like to proceed? [Y/N]: "), read(Consent),
    (Consent = 'Y' ; Consent = 'y'),
    nl, nl, nl,

    % Get the HPI
    getHPI(PatientName).

/* Get the Patient's HPI */
getHPI(P) :-

    % Temperature
    write("Please enter your temperature (in degrees celsius) : "), read(Temp),
    assert(temperature(P, Temp)),

    % Diastolic Blood Pressure
    write("Please enter your diastolic blood pressure (in mmHg) : "), read(DiasBP),

    % Systolic Blood Pressure
    write("Please enter your systolic blood pressure (in mmHg) : "), read(SysBP),
    assert(bloodPressure(P, DiasBP, SysBP)),

    