/*
    CSINTSY MCO3
    AMOGUIS, Adriel Isaiah V.
    SUN, Benedict C.

    MAIN PROGRAM HANDLER
*/
% Load the diseases knowledge base
:- consult("Diseases").

% Predicate to Start PROGRAM - ENGLISH
startENSession(PatientName) :-
    write_ln("Barangay Level of Common Rural Diseases."),
    write_ln("We will be asking you a series of questions regarding your symptoms to establish an idea of possible illnesses."),

    % Always ask for consent
    write("Would you like to proceed? [Y/N]: "), read(Consent),
    (Consent = 'Y' ; Consent = 'y'),

    % Proceed for positive consent
    nl, nl, nl,

    % Greet User
    format("Good day, ~w!", [PatientName]), nl, nl,

    % Start Questionnaire
    enQuestionnaire(PatientName),

    % Display Symptoms
    write_ln("Here are the base symptoms inputted:"), nl,
    displaySymptoms(PatientName), nl, nl, nl,

    % Display Higher-Order Symptoms
    write_ln("Here are the higher-order symptoms derived:"), nl,
    displayHigherSymptoms(PatientName), nl, nl, nl,

    % Display the Actual Diseases
    write_ln("Here are the actual diseases derived:"), nl,
    displayDisease(PatientName).

% Symptom Questionnaire
enQuestionnaire(PatientName) :-

    % Question 1 : headache
    write("Have you been experiencing headaches? [Y/N] : "), read(HasHeadache), (((HasHeadache = 'y' ; HasHeadache = 'Y') -> assert(headache(PatientName))) ; true),
    write("Have you been having high temperatures? [Y/N] : "), read(HasHighTemp), (((HasHighTemp = 'y' ; HasHighTemp = 'Y') -> assert(highTemp(PatientName))) ; true),
    write("Have you been having low temperatures? [Y/N] : "), read(HasLowTemp), (((HasLowTemp = 'y' ; HasLowTemp = 'Y') -> assert(lowTemp(PatientName))) ; true),
    write("Have you been feeling cold? [Y/N] : "), read(Cold), (((Cold = 'y' ; Cold = 'Y') -> assert(feelingCold(PatientName))) ; true),
    write("Have you been vomiting? [Y/N] : "), read(BeenVomiting), (((BeenVomiting = 'y' ; BeenVomiting = 'Y') -> assert(vomiting(PatientName))) ; true),
    write("Have you been nauseous lately? [Y/N] : "), read(BeenNauseous), (((BeenNauseous = 'y' ; BeenNauseous = 'Y') -> assert(nausea(PatientName))) ; true),
    write("Have you been feeling weak lately? [Y/N] : "), read(FeelingWeak), (((FeelingWeak = 'y' ; FeelingWeak = 'Y') -> assert(feelsWeak(PatientName))) ; true),
    write("Have you been pale? [Y/N] : "), read(IsPale), (((IsPale = 'y' ; IsPale = 'Y') -> assert(pale(PatientName))) ; true),
    write("Do you have red spots all over your body? [Y/N] : "), read(HasSpots), (((HasSpots = 'y' ; HasSpots = 'Y') -> assert(redSpots(PatientName))) ; true),
    write("Have you been having body pain? [Y/N] : "), read(HasBodyPain), (((HasBodyPain = 'y' ; HasBodyPain = 'Y') -> assert(bodyPain(PatientName))) ; true),
    write("Have you been having sore muscles? [Y/N] : "), read(HasSoreMuscles), (((HasSoreMuscles = 'y' ; HasSoreMuscles = 'Y') -> assert(soreMuscles(PatientName))) ; true),
    write("Have you been having chest pain? [Y/N] : "), read(HasChestPain), (((HasChestPain = 'y' ; HasChestPain = 'Y') -> assert(chestPain(PatientName))) ; true),
    write("Have you been coughing lately? [Y/N] : "), read(HasCough), (((HasCough = 'y' ; HasCough = 'Y') -> assert(cough(PatientName))) ; true),
    write("Have you been bleeding in any way lately (even bleeding phlegm)? [Y/N] : "), read(IsBleeding), (((IsBleeding = 'y' ; IsBleeding = 'Y') -> assert(bleeding(PatientName))) ; true),
    write("Have you been having phlegm lately? [Y/N] : "), read(HasSputum), (((HasSputum = 'y' ; HasSputum = 'Y') -> assert(phlegm(PatientName))) ; true),
    write("Have you been constantly weak lately ? [Y/N] : "), read(IsWeak), (((IsWeak = 'y' ; IsWeak = 'Y') -> assert(weakness(PatientName))) ; true),
    write("Have you been feeling tired lately? [Y/N] : "), read(Tired), (((Tired = 'y' ; Tired = 'Y') -> assert(tired(PatientName))) ; true),
    write("Have you been losing weight lately? [Y/N] : "), read(LosingWeight), (((LosingWeight = 'y' ; LosingWeight = 'Y') -> assert(weightLoss(PatientName))) ; true),
    write("Have you been having no appetite lately? [Y/N] : "), read(NoAppetiate), (((NoAppetiate = 'y' ; NoAppetiate = 'Y') -> assert(noAppetite(PatientName))) ; true),
    write("Have you been sweating at night? [Y/N] : "), read(SweatNight), (((SweatNight = 'y' ; SweatNight = 'Y') -> assert(nightSweat(PatientName))) ; true),
    write("Have you been having shortness of breath? [Y/N] : "), read(NoBreath), (((NoBreath = 'y' ; NoBreath = 'Y') -> assert(shortnessBreath(PatientName))) ; true),
    write("Have you been having morning headaches? [Y/N] : "), read(MorningHeadaches), (((MorningHeadaches = 'y' ; MorningHeadaches = 'Y') -> assert(morningHeadache(PatientName))) ; true),
    write("Have you been having irregular pulse? [Y/N] : "), read(BadPulse), (((BadPulse = 'y' ; BadPulse = 'Y') -> assert(badPulse(PatientName))) ; true),
    write("Have you been having blurry vision? [Y/N] : "), read(Blurry), (((Blurry = 'y' ; Blurry = 'Y') -> assert(blurryVision(PatientName))) ; true),
    write("Have you been having trouble hearing? [Y/N] : "), read(BadHearing), (((BadHearing = 'y' ; BadHearing = 'Y') -> assert(troubleHearing(PatientName))) ; true),
    write("Have you been having cramps? [Y/N] : "), read(Cramps), (((Cramps = 'y' ; Cramps = 'Y') -> assert(cramps(PatientName))) ; true),
    write("Have you been super confused lately? [Y/N] : "), read(IsConfused), (((IsConfused = 'y' ; IsConfused = 'Y') -> assert(confusion(PatientName))) ; true),
    write("Have you been extra anxious lately? [Y/N] : "), read(Anxious), (((Anxious = 'y' ; Anxious = 'Y') -> assert(anxiety(PatientName))) ; true),
    write("Have you been wheezing hard lately? [Y/N] : "), read(Wheezing), (((Wheezing = 'y' ; Wheezing = 'Y') -> assert(wheezing(PatientName))) ; true),
    write("Have you been having a midly warm body temperature lately? [Y/N] : "), read(MildWarm), (((MildWarm = 'y' ; MildWarm = 'Y') -> assert(mildTemperature(PatientName))) ; true),
    write("Have you been having a loose bowel movement lately? [Y/N] : "), read(LBM), (((LBM = 'y' ; LBM = 'Y') -> assert(looseStools(PatientName))) ; true),
    write("Have you been having abdominal pain lately? [Y/N] : "), read(AbdomenPain), (((AbdomenPain = 'y' ; AbdomenPain = 'Y') -> assert(abdominalPain(PatientName))) ; true),
    write("Have you been having a lack of fluid intake lately? [Y/N] : "), read(BadHydro), (((BadHydro = 'y' ; BadHydro = 'Y') -> assert(noHydration(PatientName))) ; true),

    write_ln("That's it for the questionnaire!").

% Display Symptoms
displaySymptoms(P) :-
    ((headache(P) -> format("~w has a headache.~n", [P])) ; true),
    ((highTemp(P) -> format("~w has a high temperature.~n", [P])) ; true),
    ((lowTemp(P) -> format("~w has a low temperature.~n", [P])) ; true),
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
    ((bleeding(P) -> format("~w has been bleeding.~n", [P])) ; true),
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
    ((mildTemperature(P) -> format("~w has been having mildly warm temperatures.~n", [P])) ; true),
    ((looseStools(P) -> format("~w has been having loose bowel movement.~n", [P])) ; true),
    ((abdominalPain(P) -> format("~w has been having abdominal pains.~n", [P])) ; true),
    ((noHydration(P) -> format("~w has been having poor liquid intake.~n", [P])) ; true),

    write_ln("That's all for base symptoms.").

% Display Higher-Order Symptoms
displayHigherSymptoms(P) :-
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

    write_ln("That's all for higher-order symptoms.").

% Diplay Actual Illness/Disease
displayDisease(P) :-
    ((malaria(P) -> format("~w has Malaria.~n", [P])) ; true),
    ((dengue(P) -> format("~w has Dengue.~n", [P])) ; true),
    ((tuberculosis(P) -> format("~w has Tuberculosis.~n", [P])) ; true),
    ((pneumonia(P) -> format("~w has Pneumonia.~n", [P])) ; true),
    ((mildHypertension(P) -> format("~w has Mild Hypertension.~n", [P])) ; true),
    ((severeHypertension(P) -> format("~w has Severe Hypertension.~n", [P])) ; true),
    ((diarrhea(P) -> format("~w has Diarrhea.~n", [P])) ; true),

    write_ln("That's all for diseases.").