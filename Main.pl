/*
    CSINTSY - MCO3

    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.
*/

% Import the Diseases Module
:- consult("Diseases.pl").

% Special Dynamic Facts
:- dynamic emergency/1.
:- dynamic diagnosis/3.

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
    
    % Get the Chief Complaint and Diagnose
    (chiefComplaint(PatientName) ; true), !,

    % Parse Results
    diagnosedSummary(PatientName).

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
    (viralQuestionnaire(P) ; true), !,

    % Check if the patient is already diagnosed
    not(diagnosis(P, _, _)),

    % RESPIRATORY
    (respiratoryQuestionnaire(P) ; true), !,

    % Check if the patient is already diagnosed
    not(diagnosis(P, _, _)),

    % GASTRO
    (gastroQuestionnaire(P) ; true), !,

    % Check if the patient is already diagnosed
    not(diagnosis(P, _, _)),

    % LIFESTYLE
    lifestyleQuestionnaire(P), !.


/* Questions for Viral Diseases */
viralQuestionnaire(P) :-

    % Patient Must Have a Fever
    fever(P),

    % Body Malaise
    write("Do you feel an overall weakness in your whole body? [Y/N] : "), read(BM),
    ((BM = 'y' ; BM = 'Y') -> assert(malaise(P)) ; true),

    % Runny Nose / Colds
    write("Do you have a runny nose? [Y/N] : "), read(RN),
    ((RN = 'y' ; RN = 'Y') -> assert(runnyNose(P)) ; true),

    write("Do you have colds? [Y/N] : "), read(Lamig),
    ((Lamig = 'y' ; Lamig = 'Y') -> assert(cold(P)) ; true),

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
        (malaria(P, MalariaCertainty))

    ) ; true),

    % Test for Dengue (if there is body malaise)
    (malaise(P) -> (

        (not(headache(P)) -> (write("Are you having frequent headaches? [Y/N] : "), read(HAA),
        ((HAA = 'Y' ; HAA = 'y') -> assert(headache(P)) ; true)); true),

        write("Are you having rashes? [Y/N] : "), read(Rash),
        ((Rash = 'Y' ; Rash = 'y') -> assert(rash(P)) ; true),

        % Get Dengue Certainty
        (dengue(P, DengueCertainty))

    ) ; true),

    % If malaise does not exist, declare certainties to 0
    (not(malaise(P)) -> DengueCertainty is 0, MalariaCertainty is 0 ; true),

    % Test for Flu (if there is colds/runnynose)
    (runnyNose(P) -> (

        (not(cough(P)) -> (write("Are you having cough? [Y/N] : "), read(Cough),
        ((Cough = 'Y' ; Cough = 'y') -> assert(cough(P))) ; true); true),

        % Get Flu Certainty
        (flu(P, FluCertainty))

    ) ; true),
    
    % If there is no runny nose, declare certainty to 0
    (not(runnyNose(P)) -> FluCertainty is 0 ; true), !,

    % Check if any certainties are over 75, if not emergency
    (not(emergency(P)) -> (
        ((FluCertainty >= 75) -> assert(diagnosis(P, "Flu", FluCertainty)) ; true), !,
        ((DengueCertainty >= 75) -> assert(diagnosis(P, "Dengue", DengueCertainty)) ; true), !,
        ((MalariaCertainty >= 75) -> assert(diagnosis(P, "Malaria", MalariaCertainty)) ; true), !
    ); true), !,

    % If emergency, store diagnosis anyway
    ((emergency(P) -> (
        assert(diagnosis(P, "Flu", FluCertainty)),
        assert(diagnosis(P, "Dengue", DengueCertainty)),
        assert(diagnosis(P, "Malaria", MalariaCertainty))
    )); true), !.

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

        % Get TB Certainty
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
    (wheezing(P) -> (bronchitis(P, BronchitisCertainty) ; true)),

    % Set certainty to 0 if not wheezing
    (not(wheezing(P)) -> BronchitisCertainty is 0 ; true),

    % Check if any certainties are over 75, if not emergency
    (not(emergency(P)) -> (
        ((TBCertainty >= 75) -> assert(diagnosis(P, "Tuberculosis", TBCertainty)) ; true), !,
        ((PneuCertainty >= 75) -> assert(diagnosis(P, "Pneumonia", PneuCertainty)) ; true), !,
        ((BronchitisCertainty >= 75) -> assert(diagnosis(P, "Bronchitis", BronchitisCertainty)) ; true), !
    ); true), !,

    % If emergency, store diagnosis anyway
    ((emergency(P) -> (
        assert(diagnosis(P, "Flu", TBCertainty)),
        assert(diagnosis(P, "Pneumonia", PneuCertainty)),
        assert(diagnosis(P, "Bronchitis", BronchitisCertainty))
    )); true), !.

/* Questions for Gastrointestinal Diseases */
gastroQuestionnaire(P) :-

    % Check if the patient has loose bowel movement

    % LBM
    write("Are you having loose bowel movement? [Y/N] : "), read(LBM),
    ((LBM = 'y' ; LBM = 'Y') -> assert(looseStools(P)) ; true),

    % Must have looseStools
    looseStools(P),

    % Check for diarrhea
    
    % Check for Abdominal Pain
    write("Are you experiencing abdominal pain? [Y/N] : "), read(AwitTiyan),
    ((AwitTiyan = 'y' ; AwitTiyan = 'Y') -> assert(abdominalPain(P)) ; true),

    % Check for Dehydration
    write("Are you dehydrated? [Y/N] : "), read(Dehyd),
    ((Dehyd = 'y' ; Dehyd = 'Y') -> assert(dehydration(P)) ; true),

    % Get Diarrhea Certainty
    diarrhea(P, DiarrheaCertainty),

    % Check for Cholera only if there is diarrhea
    ((diarrhea(P, DCer), DCer >= 75) -> (

        % Check for more profuse bowel movement
        write("Is your bowel movement really severe (totally liquid)? [Y/N] : "), read(AwitAwitTiyan),
        ((AwitAwitTiyan = 'y' ; AwitAwitTiyan = 'Y') -> assert(fasterStools(P)) ; true),

        % Check for more profuse dehydration
        write("Is your dehydration severe? [Y/N] : "), read(AwitDehydration),
        ((AwitDehydration = 'y' ; AwitDehydration = 'Y') -> assert(fasterDehydration(P)) ; true),

        % Get cholera certainty
        cholera(P, CholeraCertainty)

    ) ; true),

    (not((diarrhea(P, DCCer), DCCer >= 75)) -> CholeraCertainty is 0 ; true),

    % Check if any certainties are over 75, if not emergency
    (not(emergency(P)) -> (
        ((DiarrheaCertainty >= 75) -> assert(diagnosis(P, "Diarrhea", DiarrheaCertainty)) ; true), !,
        ((CholeraCertainty >= 75) -> assert(diagnosis(P, "Cholera", CholeraCertainty)) ; true), !
    ); true), !,

    % If emergency, store diagnosis anyway
    ((emergency(P) -> (
        assert(diagnosis(P, "Diarrhea", DiarrheaCertainty)),
        assert(diagnosis(P, "Cholera", CholeraCertainty))
    )); true), !.

/* Questions for Lifestyle Diseases */
lifestyleQuestionnaire(P) :-

    % HYPERTENSION - Patient must have elevated blood pressure
    (highBP(P) -> (

        % Check for Headache
        write("Are you experiencing headaches? [Y/N] : "), read(SakitUlo),
        ((SakitUlo = 'y' ; SakitUlo = 'Y') -> assert(headache(P)) ; true),

        % Vision Changes
        write("Are you experiencing vision changes? [Y/N] : "), read(IbaPagtingin),
        ((IbaPagtingin = 'y' ; IbaPagtingin = 'Y') -> assert(visionChanges(P)) ; true),

        % Get Hypertension Certainty
        hypertension(P, HypertensionCertainty)

    ) ; true),

    (not(highBP(P)) -> HypertensionCertainty is 0 ; true),

    % DIABETES - Check for all symptoms

    % Check for Increased Urination
    write("Are you experiencing increased urination? [Y/N] : "), read(DamingIhi),
    ((DamingIhi = 'y' ; DamingIhi = 'Y') -> assert(increasedUrine(P)) ; true),

    % Check for Increased Thirst
    write("Are you experiencing increased thirst? [Y/N] : "), read(Uhaw),
    ((Uhaw = 'y' ; Uhaw = 'Y') -> assert(increasedThirst(P)) ; true),

    % Check for Weight Loss
    write("Have you been losing weight lately? [Y/N] : "), read(GettingLighter),
    ((GettingLighter = 'y' ; GettingLighter = 'Y') -> assert(weightLoss(P)) ; true),

    % Check for Family History
    write("Do you have family history of Diabetes? [Y/N] : "), read(FamHistoryDiabetes),
    ((FamHistoryDiabetes = 'y' ; FamHistoryDiabetes = 'Y') -> assert(diabetesFamily(P)) ; true),

    % Get Diabetes Certainty
    (diabetes(P, DiabetesCertainty) ; true),

    % Check if any certainties are over 75, if not emergency
    (not(emergency(P)) -> (
        ((HypertensionCertainty >= 75) -> assert(diagnosis(P, "Hypertension", HypertensionCertainty)) ; true), !,
        ((DiabetesCertainty >= 75) -> assert(diagnosis(P, "Diabetes", DiabetesCertainty)) ; true), !
    ); true), !,

    % If emergency, store diagnosis anyway
    ((emergency(P) -> (
        assert(diagnosis(P, "Hypertension", HypertensionCertainty)),
        assert(diagnosis(P, "Diabetes", DiabetesCertainty))
    )); true), !.

/* Get the Patient's Diagnosis Summary */
diagnosedSummary(P) :-

    %  EMERGENCY
    (emergency(P) -> (

        write("Emergency\n"),
        % Display all the listed Diagnosis
        write_ln("Here are our findings (with corresponding certainty level):"), (getDiagnosis(P) ; true), !

    ) ; true),

    % NON-EMERGENCY
    (not(emergency(P)) -> (

        % Check if there is a valid diagnosis
        ((not(diagnosis(P, _, _)) -> write_ln("This system cannot provide a diagnosis. Please visit a higher health institution.")); true), !,

        % Display only the top diagnosis
        ((diagnosis(P, _, _) -> (

            % Get the top
            getTopDiagnosis(P, [Name | [Certainty | _]]),

            write_ln("You have been diagnosed with the following:"),
            format("~s with a certainty level of ~w%~n", [Name, Certainty])

        )) ; true), !

    ) ; true).

/* UTILITY PREDICATES */

% Print Diagnosis
getDiagnosis(P) :- 
    retract(diagnosis(P, D, C)),
    format("| ~w~20t | ~w~20t |~n", [D,C]),
    getDiagnosis(P).

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