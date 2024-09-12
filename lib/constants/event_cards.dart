import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/event_action.dart';
import 'package:bankopol/models/event_card.dart';

final eventCards = [
  const EventCard(
    description: 'Räntan höjs överraskande, du får en extra bonus!',
    eventAction: EventAction(
      investmentType: InvestmentType.savingsAccount,
      amountValue: 200,
    ),
  ),
  const EventCard(
    description: 'Kontoavgiften höjs, du förlorar en liten summa',
    eventAction: EventAction(
      investmentType: InvestmentType.savingsAccount,
      amountValue: 50,
    ),
  ),
  const EventCard(
    description:
        'Du uppfyller villkoren och får den utlovade höga räntan denna månad',
    eventAction: EventAction(
      investmentType: InvestmentType.highYieldSavingsAccount,
      percentValue: 0.05,
    ),
  ),
  const EventCard(
    description: 'Du missar ett villkor och får endast grundräntan denna månad',
    eventAction: EventAction(
      investmentType: InvestmentType.highYieldSavingsAccount,
      percentValue: 0.0,
    ),
  ),
  const EventCard(
    description: 'Som tack för att du har ett fasträntekonto får du en bonus',
    eventAction: EventAction(
      investmentType: InvestmentType.fixedRateAccount,
      amountValue: 50,
    ),
  ),
  const EventCard(
    description:
        'Du behöver pengarna akut men kontot är låst, du måste betala en straffavgift för att ta ut dem',
    eventAction: EventAction(
      investmentType: InvestmentType.fixedRateAccount,
      amountValue: -100,
    ),
  ),
  const EventCard(
    description: 'Schablonbeskattningen sänks, du betalar mindre skatt i år',
    eventAction: EventAction(
      investmentType: InvestmentType.investmentSavingsAccount,
      amountValue: 100,
    ),
  ),
  const EventCard(
    description:
        'Börsen kraschar, värdet på dina investeringar minskar drastiskt',
    eventAction: EventAction(
      investmentType: InvestmentType.investmentSavingsAccount,
      percentValue: -0.5,
    ),
  ),
  const EventCard(
    description: 'Du får en oväntad utdelning från en av dina fonder',
    eventAction: EventAction(
      investmentType: InvestmentType.capitalInsurance,
      amountValue: 1000,
    ),
  ),
  const EventCard(
    description:
        'Försäkringsbolaget går i konkurs, du förlorar en del av dina investeringar',
    eventAction: EventAction(
      investmentType: InvestmentType.capitalInsurance,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Företaget du investerat i gör ett stort genombrott, aktiekursen skjuter i höjden',
    eventAction: EventAction(
      investmentType: InvestmentType.stocks,
      percentValue: 0.5,
    ),
  ),
  const EventCard(
    description: 'En skandal skakar företaget, aktiekursen rasar',
    eventAction: EventAction(
      investmentType: InvestmentType.stocks,
      percentValue: -0.1,
    ),
  ),
  const EventCard(
    description:
        'Fondförvaltaren gör några smarta val, din fond överträffar index',
    eventAction: EventAction(
      investmentType: InvestmentType.funds,
      percentValue: 0.2,
    ),
  ),
  const EventCard(
    description:
        'Fonden har höga avgifter som äter upp en del av din avkastning',
    eventAction: EventAction(
      investmentType: InvestmentType.funds,
      amountValue: -100,
    ),
  ),
  const EventCard(
    description:
        'Emittenten betalar ut räntan i förtid, du får extra pengar nu',
    eventAction: EventAction(
      investmentType: InvestmentType.bonds,
      amountValue: 1500,
    ),
  ),
  const EventCard(
    description:
        'Emittenten går i konkurs, du förlorar hela eller delar av din investering',
    eventAction: EventAction(
      investmentType: InvestmentType.bonds,
      amount: -3,
    ),
  ),
  const EventCard(
    description:
        'En oväntad brist uppstår, priset på din råvara stiger kraftigt',
    eventAction: EventAction(
      investmentType: InvestmentType.commodities,
      percentValue: 1,
    ),
  ),
  const EventCard(
    description:
        'En ny teknik gör din råvara omodern, priset sjunker drastiskt',
    eventAction: EventAction(
      investmentType: InvestmentType.commodities,
      amountValue: -100,
    ),
  ),
  const EventCard(
    description:
        'Området där du äger fastighet blir populärt, värdet ökar markant',
    eventAction: EventAction(
      investmentType: InvestmentType.realEstate,
      percentValue: .3,
    ),
  ),
  const EventCard(
    description:
        'En vattenskada uppstår i din fastighet, du måste betala för dyra reparationer',
    eventAction: EventAction(
      investmentType: InvestmentType.realEstate,
      amountValue: -1000,
    ),
  ),
  const EventCard(
    description:
        'Projektet du stöttat blir en succé, du får en andel av vinsten!',
    eventAction: EventAction(
      investmentType: InvestmentType.crowdfunding,
      amountValue: 1000,
    ),
  ),
  const EventCard(
    description: 'Projektet misslyckas, du förlorar hela din investering',
    eventAction: EventAction(
      investmentType: InvestmentType.crowdfunding,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Låntagaren betalar tillbaka i tid med ränta, du tjänar pengar',
    eventAction: EventAction(
      investmentType: InvestmentType.peerToPeerLending,
      amountValue: 1000,
    ),
  ),
  const EventCard(
    description:
        'Låntagaren går i personlig konkurs, du förlorar hela eller delar av lånet',
    eventAction: EventAction(
      investmentType: InvestmentType.peerToPeerLending,
      amount: -1,
    ),
  ),
  const EventCard(
    description:
        'Konstnären du investerat i blir känd, värdet på ditt konstverk mångdubblas',
    eventAction: EventAction(
      investmentType: InvestmentType.art,
      percentValue: 10,
    ),
  ),
  const EventCard(
    description: 'Konstverket blir skadat, värdet minskar betydligt',
    eventAction: EventAction(
      investmentType: InvestmentType.art,
      percentValue: -0.5,
    ),
  ),
  const EventCard(
    description:
        'En expert värderar dina smycken högre än du trodde, du har gjort en bra investering',
    eventAction: EventAction(
      investmentType: InvestmentType.jewelryAndGemstones,
      amountValue: 2500,
    ),
  ),
  const EventCard(
    description: 'Du blir rånad, dina smycken är borta',
    eventAction: EventAction(
      investmentType: InvestmentType.jewelryAndGemstones,
      amountValue: -1,
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
