enum InvestmentType {
  savingsAccount, // Sparkonto
  highYieldSavingsAccount, // Högavkastningssparkonto
  fixedRateAccount, // Fasträntekonto
  investmentSavingsAccount, // ISK (Investeringssparkonto)
  capitalInsurance, // Kapitalförsäkring
  stocks, // Aktier
  funds, // Fonder
  bonds, // Obligationer
  commodities, // Råvaror
  realEstate, // Fastigheter

  crowdfunding, // Crowdfunding
  peerToPeerLending, // Peer-to-peer-lån
  art, // Konst
  jewelryAndGemstones, // Smycken och ädelstenar
  wine, // Vin
  collectibles, // Samlarobjekt
  cryptocurrencies, // Kryptovalutor
  nfts, // NFT:er (Non-Fungible Tokens)

  greenBonds, // Gröna obligationer
  sustainabilityFunds, // Hållbarhetsfonder
  socialEnterprises, // Sociala företag
  microfinancing, // Mikrofinansiering

  pensionInsurance, // Pensionsförsäkring
  childInsurance, // Barnförsäkring
  lifeInsurance, // Livförsäkring
  piggyBank, // Spargris
  savingsChallenges, // Sparutmaningar
  diyInvestments, // "Gör-det-själv"-investeringar
  ;
}

String getInvestmentTypeName(InvestmentType investmentType) {
  switch (investmentType) {
    case InvestmentType.savingsAccount:
      return 'Sparkonto';
    case InvestmentType.highYieldSavingsAccount:
      return 'Högavkastningssparkonto';
    case InvestmentType.fixedRateAccount:
      return 'Fasträntekonto';
    case InvestmentType.investmentSavingsAccount:
      return 'ISK (Investeringssparkonto)';
    case InvestmentType.capitalInsurance:
      return 'Kapitalförsäkring';
    case InvestmentType.stocks:
      return 'Aktier';
    case InvestmentType.funds:
      return 'Fonder';
    case InvestmentType.bonds:
      return 'Obligationer';
    case InvestmentType.commodities:
      return 'Råvaror';
    case InvestmentType.realEstate:
      return 'Fastigheter';
    case InvestmentType.crowdfunding:
      return 'Crowdfunding';
    case InvestmentType.peerToPeerLending:
      return 'Peer-to-peer-lån';
    case InvestmentType.art:
      return 'Konst';
    case InvestmentType.jewelryAndGemstones:
      return 'Smycken och ädelstenar';
    case InvestmentType.wine:
      return 'Vin';
    case InvestmentType.collectibles:
      return 'Samlarobjekt';
    case InvestmentType.cryptocurrencies:
      return 'Kryptovalutor';
    case InvestmentType.nfts:
      return 'NFT:er (Non-Fungible Tokens)';
    case InvestmentType.greenBonds:
      return 'Gröna obligationer';
    case InvestmentType.sustainabilityFunds:
      return 'Hållbarhetsfonder';
    case InvestmentType.socialEnterprises:
      return 'Sociala företag';
    case InvestmentType.microfinancing:
      return 'Mikrofinansiering';
    case InvestmentType.pensionInsurance:
      return 'Pensionsförsäkring';
    case InvestmentType.childInsurance:
      return 'Barnförsäkring';
    case InvestmentType.lifeInsurance:
      return 'Livförsäkring';
    case InvestmentType.piggyBank:
      return 'Spargris';
    case InvestmentType.savingsChallenges:
      return 'Sparutmaningar';
    case InvestmentType.diyInvestments:
      return '"Gör-det-själv"-investeringar';
  }
}

String getInvestmentDescription(InvestmentType investmentType) {
  switch (investmentType) {
    case InvestmentType.savingsAccount:
      return 'Ett grundläggande konto med låg ränta, säkert för att spara pengar.';
    case InvestmentType.highYieldSavingsAccount:
      return 'Erbjuder högre ränta än ett vanligt sparkonto, men kan ha vissa villkor.';
    case InvestmentType.fixedRateAccount:
      return 'Pengarna låses in under en viss period till en fast ränta.';
    case InvestmentType.investmentSavingsAccount:
      return 'Konto för att investera i aktier och fonder, beskattas schablonmässigt.';
    case InvestmentType.capitalInsurance:
      return 'Liknar ISK, men med fler investeringsmöjligheter och förmånstagare.';
    case InvestmentType.stocks:
      return 'Köp andelar i företag, potential för hög avkastning men också risk.';
    case InvestmentType.funds:
      return 'En samling av olika värdepapper, diversifierar risken.';
    case InvestmentType.bonds:
      return 'Lån ut pengar till företag eller staten, får ränta i gengäld.';
    case InvestmentType.commodities:
      return 'Investera i guld, silver, olja etc., kan vara volatilt.';
    case InvestmentType.realEstate:
      return 'Köp hus eller lägenheter för att hyra ut eller sälja med vinst.';
    case InvestmentType.crowdfunding:
      return 'Investera i nya företag eller projekt via onlineplattformar.';
    case InvestmentType.peerToPeerLending:
      return 'Låna ut pengar direkt till andra privatpersoner via en plattform.';
    case InvestmentType.art:
      return 'Köp konstverk i hopp om att de ökar i värde.';
    case InvestmentType.jewelryAndGemstones:
      return 'Kan öka i värde över tid, särskilt om de är unika.';
    case InvestmentType.wine:
      return 'Investera i exklusiva viner som kan lagras och säljas senare.';
    case InvestmentType.collectibles:
      return 'Allt från frimärken till serietidningar kan bli värdefulla.';
    case InvestmentType.cryptocurrencies:
      return 'Digitala valutor som Bitcoin, hög risk och volatilitet.';
    case InvestmentType.nfts:
      return 'r (Non-Fungible Tokens): Unika digitala tillgångar, ofta kopplade till konst eller samlarobjekt.';
    case InvestmentType.greenBonds:
      return 'Finansierar miljövänliga projekt.';
    case InvestmentType.sustainabilityFunds:
      return 'Investerar i företag med fokus på ESG (miljö, socialt ansvar, bolagsstyrning).';
    case InvestmentType.socialEnterprises:
      return 'Investera i företag som har ett socialt eller miljömässigt syfte.';
    case InvestmentType.microfinancing:
      return 'Låna ut små summor till entreprenörer i utvecklingsländer.';
    case InvestmentType.pensionInsurance:
      return 'Sparande till pensionen med skattelättnader.';
    case InvestmentType.childInsurance:
      return 'Sparande till barn med förmånstagare.';
    case InvestmentType.lifeInsurance:
      return 'Ger utbetalning vid dödsfall.';
    case InvestmentType.piggyBank:
      return 'Traditionellt sätt att spara mynt och sedlar.';
    case InvestmentType.savingsChallenges:
      return 'Sätt upp mål och belöningar för att motivera sparandet.';
    case InvestmentType.diyInvestments:
      return 'Lär dig att investera på egen hand via aktiehandelsplattformar.';
  }
}

/*


Sparkonto: Ett grundläggande konto med låg ränta, säkert för att spara pengar.
Högavkastningssparkonto: Erbjuder högre ränta än ett vanligt sparkonto, men kan ha vissa villkor.
Fasträntekonto: Pengarna låses in under en viss period till en fast ränta.
ISK (Investeringssparkonto): Konto för att investera i aktier och fonder, beskattas schablonmässigt.
Kapitalförsäkring: Liknar ISK, men med fler investeringsmöjligheter och förmånstagare.
Aktier: Köp andelar i företag, potential för hög avkastning men också risk.
Fonder: En samling av olika värdepapper, diversifierar risken.
Obligationer: Lån ut pengar till företag eller staten, får ränta i gengäld.
Råvaror: Investera i guld, silver, olja etc., kan vara volatilt.
Fastigheter: Köp hus eller lägenheter för att hyra ut eller sälja med vinst.




Crowdfunding: Investera i nya företag eller projekt via onlineplattformar.
Peer-to-peer-lån: Låna ut pengar direkt till andra privatpersoner via en plattform.
Konst: Köp konstverk i hopp om att de ökar i värde.
Smycken och ädelstenar: Kan öka i värde över tid, särskilt om de är unika.
Vin: Investera i exklusiva viner som kan lagras och säljas senare.
Samlarobjekt: Allt från frimärken till serietidningar kan bli värdefulla.
Kryptovalutor: Digitala valutor som Bitcoin, hög risk och volatilitet.
NFT:er (Non-Fungible Tokens): Unika digitala tillgångar, ofta kopplade till konst eller samlarobjekt.




Gröna obligationer: Finansierar miljövänliga projekt.
Hållbarhetsfonder: Investerar i företag med fokus på ESG (miljö, socialt ansvar, bolagsstyrning).
Sociala företag: Investera i företag som har ett socialt eller miljömässigt syfte.
Mikrofinansiering: Låna ut små summor till entreprenörer i utvecklingsländer.




Pensionsförsäkring: Sparande till pensionen med skattelättnader.
Barnförsäkring: Sparande till barn med förmånstagare.
Livförsäkring: Ger utbetalning vid dödsfall.
Spargris: Traditionellt sätt att spara mynt och sedlar.
Sparutmaningar: Sätt upp mål och belöningar för att motivera sparandet.
"Gör-det-själv"-investeringar: Lär dig att investera på egen hand via aktiehandelsplattformar.
 */
