/*
    CSINTSY MCO3
    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    MAIN PROGRAM HANDLER
*/
% Load the diseases knowledge base
:- consult("Diseases").

/* Start the diagnoser */
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

    % Start the Questionnaire
    dynamicQuestionnaire(PatientName), nl, nl,

    % Display the symptoms
    displaySymptoms(PatientName), nl, nl,

    % Display the Higher-Order Symptoms
    displayHigherSymptoms(PatientName), nl, nl,

    % Display Diagnosed Diseases
    displayDisease(PatientName),

    % Dispose Records
    disposeRecords(PatientName).

/* New and Improved Dynamic Questionnaire */
dynamicQuestionnaire(P) :-
    % Prompt User of the Questionnaire
    write_ln("\nWe will now begin with the questionnaire.\n"),

    % Get User Consent
    write("Would you like to proceed? [Y/N]: "), read(Consent),
    (Consent = 'Y' ; Consent = 'y'),
    nl, nl, nl,

    /* SECTION 1: Physical Symptoms */

    % Temperature
    write("Please enter your temperature (in degrees celsius) : "), read(Temp),
    assert(temperature(P, Temp)),

    % Looking pale
    write("Have you been pale? [Y/N] : "), read(IsPale), (((IsPale = 'y' ; IsPale = 'Y') -> assert(pale(PatientName))) ; true),

    % Red Spots?
    write("Do you have red spots all over your body? [Y/N] : "), read(HasSpots), (((HasSpots = 'y' ; HasSpots = 'Y') -> assert(redSpots(PatientName))) ; true),

    % Weightloss
    write("Have you been losing weight lately? [Y/N] : "), read(LosingWeight), (((LosingWeight = 'y' ; LosingWeight = 'Y') -> assert(weightLoss(PatientName))) ; true),

    % Pulse/Heartbeat Information
     write("Have you been having irregular pulse? [Y/N] : "), read(BadPulse), (((BadPulse = 'y' ; BadPulse = 'Y') -> assert(badPulse(PatientName))) ; true),

    /* SECTION 2: Complaints */

    % Headache
    write("Have you been experiencing headaches? [Y/N] : "), read(HasHeadache), (((HasHeadache = 'y' ; HasHeadache = 'Y') -> assert(headache(PatientName))) ; true),

    % Runny nose
    write("Have you been having a runny nose? [Y/N] : "), read(RunnyNose), (((RunnyNose = 'y' ; RunnyNose = 'Y') -> assert(runnyNose(PatientName))) ; true),

    % Feeling Cold
    write("Do you constantly feel cold? [Y/N] : "), read(Cold), (((Cold = 'y' ; Cold = 'Y') -> assert(feelingCold(PatientName))) ; true),

    % Feeling Weak
    write("Have you been feeling weak lately? [Y/N] : "), read(FeelingWeak), (((FeelingWeak = 'y' ; FeelingWeak = 'Y') -> assert(feelsWeak(PatientName))) ; true),
    
    % Body Pain
    write("Have you been having body pain? [Y/N] : "), read(HasBodyPain), (((HasBodyPain = 'y' ; HasBodyPain = 'Y') -> assert(bodyPain(PatientName))) ; true),

    % Sore Muscles
    write("Have you been having sore muscles? [Y/N] : "), read(HasSoreMuscles), (((HasSoreMuscles = 'y' ; HasSoreMuscles = 'Y') -> assert(soreMuscles(PatientName))) ; true),

    % Vomiting
    write("Have you been vomiting? [Y/N] : "), read(BeenVomiting), (((BeenVomiting = 'y' ; BeenVomiting = 'Y') -> assert(vomiting(PatientName))) ; true),

    % Nausea
    write("Have you been nauseous lately? [Y/N] : "), read(BeenNauseous), (((BeenNauseous = 'y' ; BeenNauseous = 'Y') -> assert(nausea(PatientName))) ; true),

    % Chest pain
    write("Have you been having chest pain? [Y/N] : "), read(HasChestPain), (((HasChestPain = 'y' ; HasChestPain = 'Y') -> assert(chestPain(PatientName))) ; true),
    
    % Cough
    write("Have you been coughing lately? [Y/N] : "), read(HasCough), (((HasCough = 'y' ; HasCough = 'Y') -> assert(cough(PatientName))) ; true),

    % Tired
    write("Have you been feeling tired lately? [Y/N] : "), read(Tired), (((Tired = 'y' ; Tired = 'Y') -> assert(tired(PatientName))) ; true),

    % Appetite
    write("Have you been having no appetite lately? [Y/N] : "), read(NoAppetiate), (((NoAppetiate = 'y' ; NoAppetiate = 'Y') -> assert(noAppetite(PatientName))) ; true),

    % Phlegm
    write("Have you been having phlegm lately? [Y/N] : "), read(HasSputum), (((HasSputum = 'y' ; HasSputum = 'Y') -> assert(phlegm(PatientName))) ; true),

    % Shortness of Breath 
    write("Have you been having shortness of breath? [Y/N] : "), read(NoBreath), (((NoBreath = 'y' ; NoBreath = 'Y') -> assert(shortnessBreath(PatientName))) ; true),

    % Blurry Vision
    write("Have you been having blurry vision? [Y/N] : "), read(Blurry), (((Blurry = 'y' ; Blurry = 'Y') -> assert(blurryVision(PatientName))) ; true),

    % Trouble Hearing
    write("Have you been having trouble hearing? [Y/N] : "), read(BadHearing), (((BadHearing = 'y' ; BadHearing = 'Y') -> assert(troubleHearing(PatientName))) ; true),

    % Cramps
    write("Have you been having cramps? [Y/N] : "), read(Cramps), (((Cramps = 'y' ; Cramps = 'Y') -> assert(cramps(PatientName))) ; true),

    % Confusion
    write("Have you been super confused lately? [Y/N] : "), read(IsConfused), (((IsConfused = 'y' ; IsConfused = 'Y') -> assert(confusion(PatientName))) ; true),

    % Anxiety
    write("Have you been extra anxious lately? [Y/N] : "), read(Anxious), (((Anxious = 'y' ; Anxious = 'Y') -> assert(anxiety(PatientName))) ; true),

    % LBM
    write("Have you been having a loose bowel movement lately? [Y/N] : "), read(LBM), (((LBM = 'y' ; LBM = 'Y') -> assert(looseStools(PatientName))) ; true),

    % Abdominal Pain
    write("Have you been having abdominal pain lately? [Y/N] : "), read(AbdomenPain), (((AbdomenPain = 'y' ; AbdomenPain = 'Y') -> assert(abdominalPain(PatientName))) ; true),

    % Dehydration
    write("Have you been having a lack of fluid intake lately? [Y/N] : "), read(BadHydro), (((BadHydro = 'y' ; BadHydro = 'Y') -> assert(noHydration(PatientName))) ; true),

    /* SECTION 3: Follow-Up */
    % Cough Length (if has cough)
    ((cough(P) -> 
        write("How long have you been coughing? (in days) : "), read(CoughLen), ((CoughLen >= 14 -> assert(longCough(PatientName))) ; true)
    ); true),

    % Wheezing (if has cough)
    ((cough(P) -> 
        write("Have you been wheezing hard lately? [Y/N] : "), read(Wheezing), (((Wheezing = 'y' ; Wheezing = 'Y') -> assert(wheezing(PatientName))) ; true)
    ); true),

    % Night Sweat (if fever & cough)
    (((cough(P), fever(P)) -> 
        write("Have you been sweating at night? [Y/N] : "), read(SweatNight), (((SweatNight = 'y' ; SweatNight = 'Y') -> assert(nightSweat(PatientName))) ; true)
    ); true),

    % Bloody Cough (if coughing)
    ((cough(P) -> 
        write("Have you been coughing up blood? [Y/N] : "), read(IsBleeding), (((IsBleeding = 'y' ; IsBleeding = 'Y') -> assert(bloodCough(PatientName))) ; true)
    ); true),

    % Morning Headache (if irregular heartbeat)
    ((irregularHeartRhythms(P) -> 
        write("Have you been having morning headaches? [Y/N] : "), read(MorningHeadaches), (((MorningHeadaches = 'y' ; MorningHeadaches = 'Y') -> assert(morningHeadache(PatientName))) ; true)
    ); true),

    % Severe LBM (if has LBM)
    ((looseStools(P) -> 
        write("Have you been having profuse LBM? [Y/N] : "), read(ProfuseStool), (((ProfuseStool = 'y' ; ProfuseStool = 'Y') -> assert(profuseLooseStools(PatientName))) ; true)
    ); true),

    /* Wrap-Up Questionnaire */
    write_ln("\nThat's it for the questionnaire.").

/* Display base symptoms */
displaySymptoms(P) :-
    ((headache(P) -> format("~w has a headache.~n", [P])) ; true),
    ((highTemp(P) -> format("~w has a high temperature.~n", [P])) ; true),
    ((lowTemp(P) -> format("~w has a low temperature.~n", [P])) ; true),
    ((mildTemperature(P) -> format("~w has been having mildly warm temperatures.~n", [P])) ; true),
    ((feelingCold(P) -> format("~w has been feeling cold.~n", [P])) ; true),
    ((vomiting(P) -> format("~w has been vomiting.~n", [P])) ; true),
    ((nausea(P) -> format("~w has been being nauseous.~n", [P])) ; true),
    ((feelsWeak(P) -> format("~w has been feeling weak.~n", [P])) ; true),
    ((pale(P) -> format("~w is pale.~n", [P])) ; true),
    ((redSpots(P) -> format("~w has red spots.~n", [P])) ; true),
    ((bodyPain(P) -> format("~w has been having body pain.~n", [P])) ; true),
    ((soreMuscles(P) -> format("~w has been having sore muscles.~n", [P])) ; true),
    ((chestPain(P) -> format("~w has been having chest pain.~n", [P])) ; true),
    ((cough(P) -> format("~w has been coughing.~n", [P])) ; true),
    ((weakness(P) -> format("~w has constantly been weak.~n", [P])) ; true),
    ((tired(P) -> format("~w has been feeling tired.~n", [P])) ; true),
    ((weightLoss(P) -> format("~w has been losing weight.~n", [P])) ; true),
    ((noAppetite(P) -> format("~w has not been having any appetite.~n", [P])) ; true),
    ((nightSweat(P) -> format("~w has been having night sweat.~n", [P])) ; true),
    ((phlegm(P) -> format("~w has been having phlegm.~n", [P])) ; true),
    ((shortnessBreath(P) -> format("~w has been having shortness of breath.~n", [P])) ; true),
    ((morningHeadache(P) -> format("~w has been having morning headaches.~n", [P])) ; true),
    ((badPulse(P) -> format("~w has been having irregular pulse.~n", [P])) ; true),
    ((blurryVision(P) -> format("~w has been having blurry vision.~n", [P])) ; true),
    ((troubleHearing(P) -> format("~w has been having trouble hearing.~n", [P])) ; true),
    ((cramps(P) -> format("~w has been having cramps.~n", [P])) ; true),
    ((confusion(P) -> format("~w has been in confusion.~n", [P])) ; true),
    ((anxiety(P) -> format("~w has been anxious.~n", [P])) ; true),
    ((wheezing(P) -> format("~w has been wheezing.~n", [P])) ; true),
    ((looseStools(P) -> format("~w has been having loose bowel movement.~n", [P])) ; true),
    ((abdominalPain(P) -> format("~w has been having abdominal pains.~n", [P])) ; true),
    ((noHydration(P) -> format("~w has been having poor liquid intake.~n", [P])) ; true),

    write_ln("That's all for base symptoms.").

/* Display Higher-Order Symptoms */
displayHigherSymptoms(P) :-
    ((longCough(P) -> format("~w has been coughing for more than 2 weeks.~n", [P])) ; true),
    ((fever(P) -> format("~w has a fever.~n", [P])) ; true),
    ((chills(P) -> format("~w has chills.~n", [P])) ; true),
    ((malaise(P) -> format("~w has a generally weak composture.~n", [P])) ; true),
    ((rash(P) -> format("~w has rashes.~n", [P])) ; true),
    ((achesPains(P) -> format("~w has body aching and body pains.~n", [P])) ; true),
    ((bloodCough(P) -> format("~w has been coughing blood.~n", [P])) ; true),
    ((fatigue(P) -> format("~w has been fatigued.~n", [P])) ; true),
    ((irregularHeartRhythms(P) -> format("~w has irregular heart rhythm.~n", [P])) ; true),
    ((visionChanges(P) -> format("~w has fluctuating vision.~n", [P])) ; true),
    ((earBuzzing(P) -> format("~w has bad hearing.~n", [P])) ; true),
    ((muscleTremors(P) -> format("~w has muscle tremors.~n", [P])) ; true),
    ((lowFever(P) -> format("~w has low fever.~n", [P])) ; true),
    ((dehydration(P) -> format("~w is dehydrated.~n", [P])) ; true),
    ((profuseLooseStools(P) -> format("~w has severe loose bowel movement.~n", [P])) ; true),
    ((fasterDehydration(P) -> format("~w is rapidly being dehydrated (fast dehydration).~n", [P])) ; true),

    write_ln("That's all for higher-order symptoms.").

/* Display Actual Illness */
displayDisease(P) :-
    ((malaria(P) -> format("~w has Malaria.~n", [P])) ; true),
    ((dengue(P) -> format("~w has Dengue.~n", [P])) ; true),
    ((tuberculosis(P) -> format("~w has Tuberculosis.~n", [P])) ; true),
    ((pneumonia(P) -> format("~w has Pneumonia.~n", [P])) ; true),
    ((mildHypertension(P) -> format("~w has Mild Hypertension.~n", [P])) ; true),
    ((severeHypertension(P) -> format("~w has Severe Hypertension.~n", [P])) ; true),
    ((diarrhea(P) -> format("~w has Diarrhea.~n", [P])) ; true),
    ((cholera(P) -> format("~w has Cholera.~n", [P])) ; true),
    ((flu(P) -> format("~w has the Flu.~n", [P])) ; true),

    write_ln("That's all for diseases.").

/* Clean-Up Session */
disposeRecords(PatientName) :-
    write("Disposing records\n").

/* ########################## UTILITY ########################## */