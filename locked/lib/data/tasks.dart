import '../models/task_collection.dart';

final List<TaskCollection> taskCollections = [
  TaskCollection(
    theme: 'Theme 1',
    questions: [
      TaskQuestion(
        question: 'Hvad er den primære funktion ved en VPN (Virtual Private Network)?',
        answers: ['At øge hastigheden på dit internet', 'At sikre din forbindelse ved at kryptere data og skjule din IP-adresse', 'At installere antivirus automatisk', 'At gemme dine filer i skyen'],
        correctAnswerIndex: 2,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
      TaskQuestion(
        question: 'Hvorfor er det vigtigt at føre logs over loginforsøg og systemadgang?',
        answers: ['Så man kan identificere og forhindre uautoriseret adgang og potentielle angreb', 'Så man kan analysere systemets hastighed', 'Så man kan tælle, hvor mange der bruger systemet dagligt', 'Så man har dokumentation ved sikkerhedshændelser'],
        correctAnswerIndex: 4,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
    ],
    reflectionScenario: 'Du er på ferie og får en mail omkring at din virksomhedsmail er blevet brugt til at sende spam.',
    reflectionQuestion: 'Hvilke steps ville du tage - og ville du have adgang til de nødvendige værktøjer eller kontakter?',
  ),

  TaskCollection(
    theme: 'Theme 2',
    questions: [
      TaskQuestion(
        question: 'Hvad skal en virksomhed gøre, hvis de opdager et databrud, der involverer persondata?',
        answers: ['Informere de berørte personer med det samme og vente på deres feedback', 'Ignorere det, da det kan være en falsk alarm', 'Undersøge hændelsen og rapportere det til relevante myndigheder inden for 72 timer', 'Tænke på mulige løsninger internt og tage handling uden at informere myndighederne'],
        correctAnswerIndex: 3,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
      TaskQuestion(
        question: 'Hvad bør man sikre sig, når man bruger en IT-leverandør, der håndterer kundedata?',
        answers: ['At der er en databehandleraftale og sikkerhed på plads', 'At leverandøren er ISO-certificeret og har servere i EU', 'At der er tydelige kontaktpersoner og mulighed for løbende support', 'At leverandøren kun opbevarer data på deres egne servere uden at bruge tredjepartsleverandører'],
        correctAnswerIndex: 1,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
    ],
    reflectionScenario: 'Hvis en kunde spurgte dig hvordan deres data er beskyttet, hvad ville du kunne fortælle dem?',
    reflectionQuestion: 'Ville du føle dig sikker i at forklare dem det?',
  ),
];