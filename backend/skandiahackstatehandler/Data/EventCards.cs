using System.Collections.Immutable;
using System.Runtime.ConstrainedExecution;
using skandiahackstatehandler.Data.Enums;

namespace skandiahackstatehandler.Data;

public record EventCard
{
  required public string description { get; init; }
  required public EventAction eventAction { get; init; }

  public record EventAction
  {
    public InvestmentType investmentType { get; }
    public double? amountValue { get; }
    public double? percentValue { get; }
    public int? amount { get; }

    public EventAction(
      InvestmentType investmentType,
      double? amountValue = null,
      double? percentValue = null,
      int? amount = null
    )
    {
      // if (!(amountValue != null && percentValue != null && amount != null))
      // {
      //   throw new Exception();
      // }
      this.investmentType = investmentType;
      this.amount = amount;
      this.amountValue = amountValue;
      this.percentValue = percentValue;
    }

  }
}

public static class EventCards
{
  public static readonly ImmutableList<EventCard> events = [
  new() {
    description= "Räntan höjs överraskande, alla får en extra bonus!",
    eventAction= new EventCard.EventAction(
      investmentType: InvestmentType.savingsAccount,
      amountValue: 200
    )
  },
  new() {
    description = "Kontoavgiften höjs, alla förlorar en liten summa",
    eventAction= new EventCard.EventAction(
      investmentType: InvestmentType.savingsAccount,
      amountValue: 50
    ),
  },
  new() {
    description =
        "Alla uppfyller villkoren och får den utlovade höga räntan denna månad",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.highYieldSavingsAccount,
      percentValue: 0.05
    ),
  },
  new() {
    description =
        "Alla missar sina villkor och får endast grundräntan denna månad",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.highYieldSavingsAccount,
      percentValue: 0.0
    ),
  },
  new() {
    description = "Som tack till alla med ett fasträntekonto får alla en bonus",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.fixedRateAccount,
      amountValue: 50
    ),
  },
  new() {
    description =
        "Alla är i akut behov av pengar men kontona är låsta, alla måste betala en straffavgift för att ta ut dem",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.fixedRateAccount,
      amountValue: -100
    ),
  },
  new() {
    description = "Schablonbeskattningen sänks, alla betalar mindre skatt i år",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.investmentSavingsAccount,
      amountValue: 100
    ),
  },
  new() {
    description =
        "Börsen kraschar, värdet på allas investeringar minskar drastiskt",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.investmentSavingsAccount,
      percentValue: -0.5
    ),
  },
  new() {
    description = "Alla får en oväntad utdelning från en fond",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.capitalInsurance,
      amountValue: 1000
    ),
  },
  new() {
    description =
        "Försäkringsbolaget går i konkurs, alla förlorar en del av sina investeringar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.capitalInsurance,
      amount: -1
    ),
  },
  new() {
    description =
        "Företagen som har investerats i gör stora genombrott, aktiekurserna skjuter i höjden",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.stocks,
      percentValue: 0.5
    ),
  },
  new() {
    description = "En skandal skakar företagen, aktiekurserna rasar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.stocks,
      percentValue: -0.1
    ),
  },
  new() {
    description =
        "Fondförvaltaren gör några smarta val, allas fonder överträffar index",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.funds,
      percentValue: 0.2
    ),
  },
  new() {
    description =
        "Fonderna har höga avgifter som äter upp en del av avkastningen",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.funds,
      amountValue: -100
    ),
  },
  new() {
    description =
        "Emittenten betalar ut räntan i förtid, alla får extra pengar nu",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.bonds,
      amountValue: 1500
    ),
  },
  new() {
    description =
        "Emittenten går i konkurs, alla förlorar hela eller delar av sin investering",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.bonds,
      amount: -3
    ),
  },
  new() {
    description =
        "En oväntad brist uppstår, priset på råvarorna stiger kraftigt",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.commodities,
      percentValue: 1
    ),
  },
  new() {
    description =
        "En ny teknik gör råvarorna omoderna, priset sjunker drastiskt",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.commodities,
      amountValue: -100
    ),
  },
  new() {
    description = "Fastigheterna blir populära, värdet ökar markant",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.realEstate,
      percentValue: .3
    ),
  },
  new() {
    description =
        "En tornado drar igenom allas fastigheter, alla måste betala för dyra reparationer",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.realEstate,
      amountValue: -1000
    ),
  },
  new() {
    description =
        "Projekten som stöttats gör succé, alla får en andel av vinsten!",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.crowdfunding,
      amountValue: 1000
    ),
  },
  new() {
    description = "Projekten misslyckas, alla förlorar sina investeringar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.crowdfunding,
      amount: -1
    ),
  },
  new() {
    description =
        "Låntagaren betalar tillbaka i tid med ränta, alla tjänar pengar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.peerToPeerLending,
      amountValue: 1000
    ),
  },
  new() {
    description =
        "Låntagaren går i personlig konkurs, alla förlorar hela eller delar av lånet",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.peerToPeerLending,
      amount: -1
    ),
  },
  new() {
    description =
        "Konsten som investerat i blir känd, värdet på alla konstverk mångdubblas",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.art,
      percentValue: 10
    ),
  },
  new() {
    description = "Alla konstverk blir skadade, värdet minskar betydligt",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.art,
      percentValue: -0.5
    ),
  },
  new() {
    description =
        "En expert värderar smycken högre än du trodde, alla har gjort bra investeringar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.jewelryAndGemstones,
      amountValue: 2500
    ),
  },
  new() {
    description = "Alla blir rånade, smyckena är borta",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.jewelryAndGemstones,
      amountValue: -5
    ),
  },
  new() {
    description =
        "Allt lagrat har nått sin topp, alla kan sälja det för ett högt pris",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.wine,
      amountValue: 1200
    ),
  },
  new() {
    description =
        "Allt vinet blir dåligt lagrat och förstörs, alla med vin förlorar sina investeringar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.wine,
      amount: -1
    ),
  },
  new() {
    description =
        "Alla samlarobjekt blir plötsligt väldigt eftertraktade, värdet stiger",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.collectibles,
      percentValue: 0.5
    ),
  },
  new() {
    description = "Trenden för ditt samlarobjekt försvinner, värdet sjunker",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.collectibles,
      amountValue: -0.3
    ),
  },
  new() {
    description =
        "En positiv nyhet får kryptovalutan att stiga kraftigt i värde",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.cryptocurrencies,
      percentValue: 0.4
    ),
  },
  new() {
    description =
        "En hackerattack stjäl allas kryptovalutor, alla förlorar allt",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.cryptocurrencies,
      amount: -1
    ),
  },
  new() {
    description = "NFTs blir viralt, alla får höga bud",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.nfts,
      amountValue: 3000
    ),
  },
  new() {
    description = "Intresset för NFT:er svalnar, värdet på NFT sjunker",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.nfts,
      percentValue: -0.8
    ),
  },
  new() {
    description =
        "Projekten som investerats i blir succé, alla får både ränta och gör gott för miljön",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.greenBonds,
      percentValue: 0.2
    ),
  },
  new() {
    description =
        "Projektet stöter på oväntade problem, avkastningen blir lägre än väntat",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.greenBonds,
      amountValue: -200
    ),
  },
  new() {
    description =
        "Fonden överträffar förväntningarna tack vare ökat intresse för hållbara investeringar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.sustainabilityFunds,
      percentValue: 0.1
    ),
  },
  new() {
    description =
        "En skandal kring ett av företagen i fonden får dess värde att sjunka",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.sustainabilityFunds,
      percentValue: -0.05
    ),
  },
  new() {
    description =
        "Företagen som investerat i gör en positiv skillnad och genererar samtidigt vinst, alla får utdelning",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.socialEnterprises,
      amountValue: 2000
    ),
  },
  new() {
    description =
        "Företaget kämpar ekonomiskt trots sitt goda syfte, investeringarna är i riskzonen",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.socialEnterprises,
      amountValue: -1000
    ),
  },
  new() {
    description =
        "Entreprenörer som lånats pengar lyckas med sitt företag och betalar tillbaka med ränta",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.microfinancing,
      amountValue: 1500
    ),
  },
  new() {
    description = "Entreprenören misslyckas och kan inte betala tillbaka lånet",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.microfinancing,
      amountValue: -500
    ),
  },
  new() {
    description =
        "Staten höjer avdragsrätten för pensionssparande, alla med pensionsförsäkring får mer pengar tillbaka på skatten",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.pensionInsurance,
      percentValue: 0.03
    ),
  },
  new() {
    description =
        "Avgifterna för din pensionsförsäkring höjs, avkastningen minskar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.pensionInsurance,
      percentValue: -0.05
    ),
  },
  new() {
    description = "Försäkringen ger en extra bonus när barn fyller 18 år",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.childInsurance,
      amountValue: 100
    ),
  },
  new() {
    description =
        "Alla spelare behöver pengar akut men kan inte ta ut dem från barnförsäkringen utan att förlora förmåner",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.childInsurance,
      amountValue: -300
    ),
  },
  new() {
    description = "Rabatt på livförsäkringspremie tack vare god hälsa",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.lifeInsurance,
      amountValue: 400
    ),
  },
  new() {
    description = "Premien höjs oväntat på grund av ändrade riskbedömningar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.lifeInsurance,
      amountValue: -150
    ),
  },
  new() {
    description =
        "Du hittar en bortglömd spargris med en oväntad summa pengar i",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.piggyBank,
      amount: 1
    ),
  },
  new() {
    description =
        "Spargrisen går sönder och alla mynt trillar ut och försvinner",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.piggyBank,
      amount: -1
    ),
  },
  new() {
    description = "Avklarad sparutmaning och får din belöning!",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.savingsChallenges,
      amountValue: 300
    ),
  },
  new() {
    description =
        "En oväntad utgift gör att alla missar sina sparutmaningar denna månad",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.savingsChallenges,
      amountValue: -300
    ),
  },
  new() {
    description =
        "Lyckade investeringar baserat på egena analyser, alla tjänar pengar",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.diyInvestments,
      percentValue: 0.1
    ),
  },
  new() {
    description =
        "Analyserna visar sig vara felaktiga, alla förlorar pengar på din investering",
    eventAction = new EventCard.EventAction(
      investmentType: InvestmentType.diyInvestments,
      percentValue: -0.05
    ),
  },
  ];
}
