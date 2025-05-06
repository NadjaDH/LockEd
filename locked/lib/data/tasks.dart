import '../models/task_collection.dart';

final List<TaskCollection> taskCollections = [
  TaskCollection(
    theme: 'Systemadgang og Ansvarlig Brug af Netværk',
    questions: [
      TaskQuestion(
        question:
            'Hvad er den primære funktion ved en VPN (Virtual Private Network)?',
        answers: [
          'At øge hastigheden på dit internet',
          'At sikre din forbindelse ved at kryptere data og skjule din IP-adresse',
          'At installere antivirus automatisk',
          'At gemme dine filer i skyen',
        ],
        correctAnswerIndex: 1,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
      TaskQuestion(
        question:
            'Hvorfor er det vigtigt at føre logs over loginforsøg og systemadgang?',
        answers: [
          'Så man kan identificere og forhindre uautoriseret adgang og potentielle angreb',
          'Så man kan analysere systemets hastighed',
          'Så man kan tælle, hvor mange der bruger systemet dagligt',
          'Så man har dokumentation ved sikkerhedshændelser',
        ],
        correctAnswerIndex: 3,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
    ],
    reflectionScenario:
        'Du er på ferie og får en mail omkring at din virksomhedsmail er blevet brugt til at sende spam.',
    reflectionQuestion:
        'Hvilke steps ville du tage - og ville du have adgang til de nødvendige værktøjer eller kontakter?',
  ),

  TaskCollection(
    theme: 'Datahåndtering og Ansvar Ved Databrud',
    questions: [
      TaskQuestion(
        question:
            'Hvordan kan følsomme data utilsigtet blive eksponeret i en cloud-løsning?',
        answers: [
          'Ved at dele data med ikke-godkendte brugere',
          'Ved fejlagtig konfiguration af adgangsrettigheder til cloud-lagring',
          'Ved at bruge cloud-løsninger uden sikkerhedsopdateringer',
          'Ved at anvende et forældet password på cloud-konti',
        ],
        correctAnswerIndex: 1,
        correctFeedback:
            'Korrekt! Fejlagtig konfiguration af adgangsrettigheder til cloud-lagring kan føre til, at data bliver offentligt tilgængelige for uautoriserede personer, hvilket eksponerer følsomme oplysninger.',
        incorrectFeedback:
            'Fejlagtig konfiguration af adgangsrettigheder til cloud-lagring kan føre til, at data bliver offentligt tilgængelige for uautoriserede personer, hvilket eksponerer følsomme oplysninger.',
      ),
      TaskQuestion(
        question:
            'Hvad bør man sikre sig, når man bruger en IT-leverandør, der håndterer kundedata?',
        answers: [
          'At der er en databehandleraftale og sikkerhed på plads',
          'At leverandøren er ISO-certificeret og har servere i EU',
          'At der er tydelige kontaktpersoner og mulighed for løbende support',
          'At leverandøren kun opbevarer data på deres egne servere uden at bruge tredjepartsleverandører',
        ],
        correctAnswerIndex: 0,
        correctFeedback: 'Korrekt! *TILFØJ TEKST*',
        incorrectFeedback: '*TILFØJ TEKST*',
      ),
    ],
    reflectionScenario:
        'Hvis en kunde spurgte dig hvordan deres data er beskyttet, hvad ville du kunne fortælle dem?',
    reflectionQuestion: 'Ville du føle dig sikker i at forklare dem det?',
  ),
];
