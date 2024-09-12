import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/event_action.dart';
import 'package:bankopol/models/event_card.dart';

final eventCards = [
  const EventCard(
    description: 'Räntan höjs överraskande, alla får en extra bonus!',
    eventAction: EventAction(
      investmentType: InvestmentType.savingsAccount,
      amountValue: 200,
    ),
  ),
  const EventCard(
    description: 'Kontoavgiften höjs, alla förlorar en liten summa',
    eventAction: EventAction(
      investmentType: InvestmentType.savingsAccount,
      amountValue: 50,
    ),
  ),
  const EventCard(
    description:
        'Alla uppfyller villkoren och får den utlovade höga räntan denna månad',
    eventAction: EventAction(
      investmentType: InvestmentType.highYieldSavingsAccount,
      percentValue: 0.05,
    ),
  ),
  const EventCard(
    description:
        'Alla missar sina villkor och får endast grundräntan denna månad',
    eventAction: EventAction(
      investmentType: InvestmentType.highYieldSavingsAccount,
      percentValue: 0.0,
    ),
  ),
  const EventCard(
    description: 'Som tack till alla med ett fasträntekonto får alla en bonus',
    eventAction: EventAction(
      investmentType: InvestmentType.fixedRateAccount,
      amountValue: 50,
    ),
  ),
  const EventCard(
    description:
        'Alla är i akut behov av pengar men kontona är låsta, alla måste betala en straffavgift för att ta ut dem',
    eventAction: EventAction(
      investmentType: InvestmentType.fixedRateAccount,
      amountValue: -100,
    ),
  ),
  const EventCard(
    description: 'Schablonbeskattningen sänks, alla betalar mindre skatt i år',
    eventAction: EventAction(
      investmentType: InvestmentType.investmentSavingsAccount,
      amountValue: 100,
    ),
  ),
  const EventCard(
    description:
        'Börsen kraschar, värdet på allas investeringar minskar drastiskt',
    eventAction: EventAction(
      investmentType: InvestmentType.investmentSavingsAccount,
      percentValue: -0.5,
    ),
  ),
  const EventCard(
    description: 'Alla får en oväntad utdelning från en fond',
    eventAction: EventAction(
      investmentType: InvestmentType.capitalInsurance,
      amountValue: 1000,
    ),
  ),
  const EventCard(
    description:
        'Försäkringsbolaget går i konkurs, alla förlorar en del av sina investeringar',
    eventAction: EventAction(
      investmentType: InvestmentType.capitalInsurance,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Företagen som har investerats i gör stora genombrott, aktiekurserna skjuter i höjden',
    eventAction: EventAction(
      investmentType: InvestmentType.stocks,
      percentValue: 0.5,
    ),
  ),
  const EventCard(
    description: 'En skandal skakar företagen, aktiekurserna rasar',
    eventAction: EventAction(
      investmentType: InvestmentType.stocks,
      percentValue: -0.1,
    ),
  ),
  const EventCard(
    description:
        'Fondförvaltaren gör några smarta val, allas fonder överträffar index',
    eventAction: EventAction(
      investmentType: InvestmentType.funds,
      percentValue: 0.2,
    ),
  ),
  const EventCard(
    description:
        'Fonderna har höga avgifter som äter upp en del av avkastningen',
    eventAction: EventAction(
      investmentType: InvestmentType.funds,
      amountValue: -100,
    ),
  ),
  const EventCard(
    description:
        'Emittenten betalar ut räntan i förtid, alla får extra pengar nu',
    eventAction: EventAction(
      investmentType: InvestmentType.bonds,
      amountValue: 1500,
    ),
  ),
  const EventCard(
    description:
        'Emittenten går i konkurs, alla förlorar hela eller delar av sin investering',
    eventAction: EventAction(
      investmentType: InvestmentType.bonds,
      amount: -3,
    ),
  ),
  const EventCard(
    description:
        'En oväntad brist uppstår, priset på råvarorna stiger kraftigt',
    eventAction: EventAction(
      investmentType: InvestmentType.commodities,
      percentValue: 1,
    ),
  ),
  const EventCard(
    description:
        'En ny teknik gör råvarorna omoderna, priset sjunker drastiskt',
    eventAction: EventAction(
      investmentType: InvestmentType.commodities,
      amountValue: -100,
    ),
  ),
  const EventCard(
    description: 'Fastigheterna blir populära, värdet ökar markant',
    eventAction: EventAction(
      investmentType: InvestmentType.realEstate,
      percentValue: .3,
    ),
  ),
  const EventCard(
    description:
        'En tornado drar igenom allas fastigheter, alla måste betala för dyra reparationer',
    eventAction: EventAction(
      investmentType: InvestmentType.realEstate,
      amountValue: -1000,
    ),
  ),
  const EventCard(
    description:
        'Projekten som stöttats gör succé, alla får en andel av vinsten!',
    eventAction: EventAction(
      investmentType: InvestmentType.crowdfunding,
      amountValue: 1000,
    ),
  ),
  const EventCard(
    description: 'Projekten misslyckas, alla förlorar sina investeringar',
    eventAction: EventAction(
      investmentType: InvestmentType.crowdfunding,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Låntagaren betalar tillbaka i tid med ränta, alla tjänar pengar',
    eventAction: EventAction(
      investmentType: InvestmentType.peerToPeerLending,
      amountValue: 1000,
    ),
  ),
  const EventCard(
    description:
        'Låntagaren går i personlig konkurs, alla förlorar hela eller delar av lånet',
    eventAction: EventAction(
      investmentType: InvestmentType.peerToPeerLending,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Konsten som investerat i blir känd, värdet på alla konstverk mångdubblas',
    eventAction: EventAction(
      investmentType: InvestmentType.art,
      percentValue: 10,
    ),
  ),
  const EventCard(
    description: 'Alla konstverk blir skadade, värdet minskar betydligt',
    eventAction: EventAction(
      investmentType: InvestmentType.art,
      percentValue: -0.5,
    ),
  ),
  const EventCard(
    description:
        'En expert värderar smycken högre än du trodde, alla har gjort bra investeringar',
    eventAction: EventAction(
      investmentType: InvestmentType.jewelryAndGemstones,
      amountValue: 2500,
    ),
  ),
  const EventCard(
    description: 'Alla blir rånade, smyckena är borta',
    eventAction: EventAction(
      investmentType: InvestmentType.jewelryAndGemstones,
      amountValue: -5,
    ),
  ),
  const EventCard(
    description:
        'Allt lagrat har nått sin topp, alla kan sälja det för ett högt pris',
    eventAction: EventAction(
      investmentType: InvestmentType.wine,
      amountValue: 1200,
    ),
  ),
  const EventCard(
    description:
        'Allt vinet blir dåligt lagrat och förstörs, alla med vin förlorar sina investeringar',
    eventAction: EventAction(
      investmentType: InvestmentType.wine,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Alla samlarobjekt blir plötsligt väldigt eftertraktade, värdet stiger',
    eventAction: EventAction(
      investmentType: InvestmentType.collectibles,
      percentValue: 0.5,
    ),
  ),
  const EventCard(
    description: 'Trenden för ditt samlarobjekt försvinner, värdet sjunker',
    eventAction: EventAction(
      investmentType: InvestmentType.collectibles,
      amountValue: -0.3,
    ),
  ),
  const EventCard(
    description:
        'En positiv nyhet får kryptovalutan att stiga kraftigt i värde',
    eventAction: EventAction(
      investmentType: InvestmentType.cryptocurrencies,
      percentValue: 0.4,
    ),
  ),
  const EventCard(
    description:
        'En hackerattack stjäl allas kryptovalutor, alla förlorar allt',
    eventAction: EventAction(
      investmentType: InvestmentType.cryptocurrencies,
      amount: -1,
    ),
  ),
  const EventCard(
    description: 'NFTs blir viralt, alla får höga bud',
    eventAction: EventAction(
      investmentType: InvestmentType.nfts,
      amountValue: 3000,
    ),
  ),
  const EventCard(
    description: 'Intresset för NFT:er svalnar, värdet på NFT sjunker',
    eventAction: EventAction(
      investmentType: InvestmentType.nfts,
      percentValue: -0.8,
    ),
  ),
  const EventCard(
    description:
        'Projekten som investerats i blir succé, alla får både ränta och gör gott för miljön',
    eventAction: EventAction(
      investmentType: InvestmentType.greenBonds,
      percentValue: 0.2,
    ),
  ),
  const EventCard(
    description:
        'Projektet stöter på oväntade problem, avkastningen blir lägre än väntat',
    eventAction: EventAction(
      investmentType: InvestmentType.greenBonds,
      amountValue: -200,
    ),
  ),
  const EventCard(
    description:
        'Fonden överträffar förväntningarna tack vare ökat intresse för hållbara investeringar',
    eventAction: EventAction(
      investmentType: InvestmentType.sustainabilityFunds,
      percentValue: 0.1,
    ),
  ),
  const EventCard(
    description:
        'En skandal kring ett av företagen i fonden får dess värde att sjunka',
    eventAction: EventAction(
      investmentType: InvestmentType.sustainabilityFunds,
      percentValue: -0.05,
    ),
  ),
  const EventCard(
    description:
        'Företagen som investerat i gör en positiv skillnad och genererar samtidigt vinst, alla får utdelning',
    eventAction: EventAction(
      investmentType: InvestmentType.socialEnterprises,
      amountValue: 2000,
    ),
  ),
  const EventCard(
    description:
        'Företaget kämpar ekonomiskt trots sitt goda syfte, investeringarna är i riskzonen',
    eventAction: EventAction(
      investmentType: InvestmentType.socialEnterprises,
      amountValue: -1000,
    ),
  ),
  const EventCard(
    description:
        'Entreprenörer som lånats pengar lyckas med sitt företag och betalar tillbaka med ränta',
    eventAction: EventAction(
      investmentType: InvestmentType.microfinancing,
      amountValue: 1500,
    ),
  ),
  const EventCard(
    description: 'Entreprenören misslyckas och kan inte betala tillbaka lånet',
    eventAction: EventAction(
      investmentType: InvestmentType.microfinancing,
      amountValue: -500,
    ),
  ),
  const EventCard(
    description:
        'Staten höjer avdragsrätten för pensionssparande, alla med pensionsförsäkring får mer pengar tillbaka på skatten',
    eventAction: EventAction(
      investmentType: InvestmentType.pensionInsurance,
      percentValue: 300,
    ),
  ),
  const EventCard(
    description:
        'Avgifterna för din pensionsförsäkring höjs, avkastningen minskar',
    eventAction: EventAction(
      investmentType: InvestmentType.pensionInsurance,
      percentValue: -0.05,
    ),
  ),
  const EventCard(
    description: 'Försäkringen ger en extra bonus när barn fyller 18 år',
    eventAction: EventAction(
      investmentType: InvestmentType.childInsurance,
      amountValue: 100,
    ),
  ),
  const EventCard(
    description:
        'Alla spelare behöver pengar akut men kan inte ta ut dem från barnförsäkringen utan att förlora förmåner',
    eventAction: EventAction(
      investmentType: InvestmentType.childInsurance,
      amountValue: -300,
    ),
  ),
  const EventCard(
    description: 'Rabatt på livförsäkringspremie tack vare god hälsa',
    eventAction: EventAction(
      investmentType: InvestmentType.lifeInsurance,
      amountValue: 400,
    ),
  ),
  const EventCard(
    description: 'Premien höjs oväntat på grund av ändrade riskbedömningar',
    eventAction: EventAction(
      investmentType: InvestmentType.lifeInsurance,
      amountValue: -150,
    ),
  ),
  const EventCard(
    description:
        'Du hittar en bortglömd spargris med en oväntad summa pengar i',
    eventAction: EventAction(
      investmentType: InvestmentType.piggyBank,
      amount: 1,
    ),
  ),
  const EventCard(
    description:
        'Spargrisen går sönder och alla mynt trillar ut och försvinner',
    eventAction: EventAction(
      investmentType: InvestmentType.piggyBank,
      amount: -1,
    ),
  ),
  const EventCard(
    description: 'Avklarad sparutmaning och får din belöning!',
    eventAction: EventAction(
      investmentType: InvestmentType.savingsChallenges,
      amountValue: 300,
    ),
  ),
  const EventCard(
    description:
        'En oväntad utgift gör att alla missar sina sparutmaningar denna månad',
    eventAction: EventAction(
      investmentType: InvestmentType.savingsChallenges,
      amountValue: -300,
    ),
  ),
  const EventCard(
    description:
        'Lyckade investeringar baserat på egena analyser, alla tjänar pengar',
    eventAction: EventAction(
      investmentType: InvestmentType.diyInvestments,
      percentValue: 0.1,
    ),
  ),
  const EventCard(
    description:
        'Analyserna visar sig vara felaktiga, alla förlorar pengar på din investering',
    eventAction: EventAction(
      investmentType: InvestmentType.diyInvestments,
      percentValue: -0.05,
    ),
  ),
];
