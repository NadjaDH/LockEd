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
        correctFeedback:
            'En VPN bruges primært til at skabe en sikker forbindelse ved at kryptere din internettrafik og skjule din IP-adresse. Det kan være relevant f.eks. ved hjemmearbejde eller arbejde offentlige steder.',
        feedback: [
          'En VPN kan faktisk sænke hastigheden, fordi trafikken sendes gennem en krypteret forbindelse. Det vigtigste ved en VPN er at beskytte din internetforbindelse ved at kryptere dine data og skjule din IP-adresse, så din aktivitet ikke kan spores.',
          'VPNer har ikke noget med antivirus at gøre og kan ikke beskytte dig mod virus direkte. VPNer beskytter dine data under overførsel, mens antivirus beskytter din enhed mod skadelige programmer, to forskellige ting.',
          'VPNer gemmer ikke data, de beskytter forbindelsen, ikke selve indholdet. Hvis du vil gemme filer i skyen, skal du bruge en cloud-tjeneste. VPNen kan dog beskytte forbindelsen til den tjeneste',
        ],
      ),
      TaskQuestion(
        question:
            'Hvorfor er det vigtigt at føre logs over loginforsøg og systemadgang?',
        answers: [
          'Så man kan identificere og forhindre uautoriseret adgang og potentielle angreb',
          'For at dokumentere alle handlinger foretaget af brugerne, uanset om de er relateret til sikkerhed',
          'For at kunne give alle brugere den samme adgang på tværs af systemer',
          'For at undgå at brugerne glemmer deres adgangskoder',
        ],
        correctAnswerIndex: 0,
        correctFeedback:
            'Logs gør det muligt at opdage usædvanlig eller mistænkelig aktivitet, så man kan reagere hurtigt og forhindre sikkerhedsbrud.',
        feedback: [
          'Det kan være en bivirkning, men ikke formålet. Logs handler først og fremmest om at overvåge adgang og beskytte systemet mod misbrug, ikke at registrere alt brugerne laver.',
          'Dette handler om brugerrettigheder og adgangsstyring, ikke logging. Logs hjælper med at overvåge adgang, de tildeler den ikke..',
          'Logging har ingen funktion i forhold til adgangskoder. Det handler om at holde øje med, hvem der forsøger at få adgang, ikke om at hjælpe med at huske adgangsoplysninger.',
        ],
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
            'En af de mest almindelige årsager til datalæk i cloud-løsninger er forkert opsatte adgangsrettigheder. Hvis man fx ikke begrænser, hvem der må tilgå visse mapper eller databaser, kan følsomme oplysninger ende med at være offentligt tilgængelige uden at man opdager det. Det er ikke nødvendigvis en fejl i systemet, men i måden det er sat op på.',
        feedback: [
          'Det kan bestemt være en risiko at dele med de forkerte, men det kræver en aktiv handling. Utilsigtet eksponering i cloud sker oftere ved forkerte standardindstillinger eller glemte begrænsninger, ikke nødvendigvis bevidst deling.',
          'Manglende opdateringer kan føre til sårbarheder, men de fører ikke i sig selv til eksponering af data. Det er mere relateret til risiko for angreb end utilsigtet eksponering.',
          'Et svagt eller gammelt password kan gøre det lettere for uvedkommende at få adgang, men det er ikke det samme som, at data utilsigtet bliver eksponeret. Det handler mere om angreb end fejlkonfiguration.',
        ],
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
        correctFeedback:
            'En databehandleraftale sikrer, at leverandøren håndterer kundedatakorrekt i henhold til lovgivning som GDPR. ISO-certificering kan være en indikator for, at leverandøren følger gode sikkerhedsstandarder, men det er stadig afgørende, at der er en databehandleraftale og konkrete sikkerhedsforanstaltninger for at beskytte data.',
        feedback: [
          'ISO-certificeringer og EU-serverplaceringer kan være positive tegn på, at leverandøren tager sikkerhed alvorligt, men de erstatter ikke de juridiske krav som en databehandleraftale og specifikke sikkerhedsforanstaltninger.',
          'Det er klart en fordel med god support og tydelige kontaktpersoner, men det har ikke noget direkte med beskyttelse af kundedata at gøre. Det er ikke nok i sig selv til at sikre lovlig og sikker behandling af persondata.',
          'Det er ikke et krav, at leverandøren ejer egne servere. Mange benytter tredjeparts cloud-leverandører, hvilket er tilladt, så længe der er styr på databehandleraftaler og sikkerheden er i orden.',
        ],
      ),
    ],
    reflectionScenario:
        'Hvis en kunde spurgte dig hvordan deres data er beskyttet, hvad ville du kunne fortælle dem?',
    reflectionQuestion: 'Ville du føle dig sikker i at forklare dem det?',
  ),
];
