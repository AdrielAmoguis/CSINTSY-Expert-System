/*
    CSINTSY - MCO3

    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.
*/

% Import the Diseases Module
:- consult("Diseases.pl").

% Special Dynamic Facts
:- dynamic emergency/1.
:- dynamic immunoCompromised/1.
:- dynamic diagnosis/3.
:- dynamic diagnosed/1.

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
    getHPI(PatientName),
    
    % Get the Chief Complaint
    (chiefComplaint(PatientName); true).

/* Get the Patient's HPI */
getHPI(P) :-

    % Ask first if emergency
    write("ARE YOU IN AN EMERGENCY? [Y/N] : "), read(EMERG),
    ((EMERG = 'y' ; EMERG = 'Y') -> assert(emergency(P)) ; true),

    % Temperature
    write("Please enter your temperature (in degrees celsius) : "), read(Temp),
    assert(temperature(P, Temp)),

    % Diastolic Blood Pressure
    write("Please enter your diastolic blood pressure (in mmHg) : "), read(DiasBP),

    % Systolic Blood Pressure
    write("Please enter your systolic blood pressure (in mmHg) : "), read(SysBP),
    assert(bloodPressure(P, DiasBP, SysBP)),

    % ImmunoCompromised
    write("Are you immunocompromised? [Y/N] : "), read(Compromised),
    ((Compromised = 'y' ; Compromised = 'Y') -> assert(immunoCompromised(P)) ; true),

    % Height
    write("Please enter your height (in centimeters) : "), read(Height),
    assert(height(P, Height)),

    % Weight
    write("Please enter your weight (in kilograms) : "), read(Weight),
    assert(weight(P, Weight)).

/* Chief Complaint Questionnaire */
chiefComplaint(P) :-

    % Gather the Chief Complaint, ask for some unique symptoms
    % VIRAL (and Malaria)
    %   - Fever, Malaise, Colds/RunnyNose
    % RESPIRATORY
    %   - Chest Pain, Coughing
    % GASTRO
    %   - LooseStools, Dehydration, Questionable Food Intake
    % CARDIO
    %   - Elevated BP
    % LIFESTYLE DISEASE
    %   - Weight Loss

    % VIRAL
    (viralQuestionnaire(P) ; true),

    % Check if the patient is already diagnosed
    not(diagnosed(P)),

    % RESPIRATORY
    (respiratoryQuestionnaire(P) ; true),

    % Check if the patient is already diagnosed
    not(diagnosed(P)),

    % GASTRO


/* Questions for Viral Diseases */
viralQuestionnaire(P) :-

    % Patient Must Have a Fever
    fever(P),

    % Body Malaise
    write("Do you feel an overall weakness in your whole body? [Y/N] : "), read(BM),
    ((BM = 'y' ; BM = 'Y') -> assert(malaise(P)) ; true),

    % Runny Nose / Colds
    write("Do you a colds or a runny nose? [Y/N] : "), read(RN),
    ((RN = 'y' ; RN = 'Y') -> assert(runnyNose(P)) ; true),

    % Test for Malaria (if there is body malaise)
    (malaise(P) -> (

        write("Do you feel chills (especially at night)? [Y/N] : "), read(Chills),
        ((Chills = 'Y' ; Chills = 'y') -> assert(chills(P)) ; true),

        write("Are you having frequent headaches? [Y/N] : "), read(HA),
        ((HA = 'Y' ; HA = 'y') -> assert(headache(P)) ; true),

        write("Are you having nausea? [Y/N] : "), read(NA),
        ((NA = 'Y' ; NA = 'y') -> assert(nausea(P)) ; true),

        write("Are you vomiting often? [Y/N] : "), read(Vomit),
        ((Vomit = 'Y' ; Vomit = 'y') -> assert(vomiting(P)) ; true),

        write("Have you been in a forest, jungle, fields, or bitten by a mosquito? [Y/N] : "), read(RiskArea),
        ((RiskArea = 'Y' ; RiskArea = 'y') -> assert(malariaRiskArea(P)) ; true),

        % Get Malaria Certainty
        malaria(P, MalariaCertainty)

    ) ; true),

    % Test for Dengue (if there is body malaise)
    (malaise(P) -> (

        write("Are you having frequent headaches? [Y/N] : "), read(HA),
        ((HA = 'Y' ; HA = 'y') -> assert(headache(P)) ; true),

        write("Are you having rashes? [Y/N] : "), read(Rash),
        ((Rash = 'Y' ; Rash = 'y') -> assert(rash(P)) ; true),

        % Get Dengue Certainty
        dengue(P, DengueCertainty)

    ) ; true),

    % If malaise does not exist, declare certainties to 0
    (not(malaise(P)) -> DengueCertainty is 0, MalariaCertainty is 0 ; true),

    % Test for Flu (if there is colds/runnynose)
    (runnyNose(P) -> (

        write("Are you having cough? [Y/N] : "), read(Cough),
        ((Cough = 'Y' ; Cough = 'y') -> assert(cough(P)) ; true),

        % Get Flu Certainty
        flu(P, FluCertainty)

    ) ; true),

    % If there is no runny nose, declare certainty to 0
    (not(runnyNose(P)) -> FluCertainty is 0 ; true),

    % Check if any certainties are over 75
    ((FluCertainty >= 75) -> assert(diagnosed(P)), assert(diagnosis(P, "Flu", FluCertainty)) ; true),
    ((DengueCertainty >= 75) -> assert(diagnosed(P)), assert(diagnosis(P, "Dengue", DengueCertainty)) ; true),
    ((MalariaCertainty >= 75) -> assert(diagnosed(P)), assert(diagnosis(P, "Malaria", MalariaCertainty)) ; true).

/* Questions for Respiratory Diseases */
respiratoryQuestionnaire(P) :-

    % Patient must have chest pain and Coughing

    % Chest Pain
    write("Are you having chest pain? [Y/N] : "), read(CP),
    ((CP = 'y' ; CP = 'Y') -> assert(chestPain(P)) ; true),

    % Coughing
    (not(cough(P)) -> (
        write("Have you been coughing? [Y/N] : "), read(Ubo),
        ((Ubo = 'y' ; Ubo = 'Y') -> assert(cough(P)) ; true)
    ) ; true),

    % Check if the patient has chest pain and is coughing
    chestPain(P), cough(P),

    % Check for Tuberculosis if coughing for more than 2 weeks
    write("Have you been coughing for 2 weeks or more? [Y/N] : "), read(MahabangUbo),
    ((MahabangUbo = 'y' ; MahabangUbo = 'Y') -> assert(longCough(P)) ; true),

    (longCough(P) -> (

        write("Do you cough up blood? [Y/N] : "), read(UboDugo),
        ((UboDugo = 'Y' ; UboDugo = 'y') -> assert(bloodCough(P)) ; true),

        % Get Dengue Certainty
        tuberculosis(P, TBCertainty)

    ) ; true),

    % Set certainty to 0 if not longCough
    (not(longCough(P)) -> TBCertainty is 0 ; true),

    % Check for Pneumonia if feverish
    (fever(P) -> (

        write("Are you having shortness of breath? [Y/N] : "), read(ShortBreath),
        ((ShortBreath = 'Y' ; ShortBreath = 'y') -> assert(shortnessBreath(P)) ; true),

        % Get Dengue Certainty
        pneumonia(P, PneuCertainty)

    ) ; true),

    % Set certainty to 0 if not feverish
    (not(fever(P)) -> PneuCertainty is 0 ; true),

    % Check for Bronchitis if Wheezing
    write("Are you wheezing? [Y/N] : "), read(Wheeze),
    ((Wheeze = 'Y' ; Wheeze = 'y') -> assert(wheezing(P)) ; true),

    % Get Bronchitis Certainty
    (bronchitis(P, BronchitisCertainty) ; true),

    % Set certainty to 0 if not wheezing
    (not(wheezing(P)) -> BronchitisCertainty is 0 ; true),

    % Check if any certainties are over 75
    ((TBCertainty >= 75) -> assert(diagnosed(P)), assert(diagnosis(P, "Tuberculosis", TBCertainty)) ; true),
    ((PneuCertainty >= 75) -> assert(diagnosed(P)), assert(diagnosis(P, "Pneumonia", PneuCertainty)) ; true),
    ((BronchitisCertainty >= 75) -> assert(diagnosed(P)), assert(diagnosis(P, "Bronchitis", BronchitisCertainty)) ; true).

/* Questions for Gastrointestinal Diseases */
gastroQuestionnaire(P) :-

    % Check if the patient has loose bowel movement

    % LBM
    write("Are you having loose bowel movement? [Y/N] : "), read(LBM),
    ((LBM = 'y' ; LBM = 'Y') -> assert(looseStools(P)) ; true),

    % Must have looseStools
    looseStools(P).

    /* Gastro diseases are too similar. Will ask for more symptoms. */

/* Questions for Lifestyle Diseases */
lifestyleQuestionnaire(P).