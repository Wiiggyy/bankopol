import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';

part 'investment_type.mapper.dart';

@MappableEnum(mode: ValuesMode.indexed)
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

  static final random = Random();

  static InvestmentType fromCode(String code) {
    final separated = code.split(':');
    switch (separated) {
      case ['event', final code]:
        final intCode = int.tryParse(code);
        if (intCode == null || intCode >= InvestmentType.values.length) {
          continue random;
        }
        return InvestmentType.values[intCode];
      random:
      case _:
        return InvestmentType
            .values[random.nextInt(InvestmentType.values.length)];
    }
  }

  String get typeName => switch (this) {
        InvestmentType.savingsAccount => 'Sparkonto',
        InvestmentType.highYieldSavingsAccount => 'Högavkastningssparkonto',
        InvestmentType.fixedRateAccount => 'Fasträntekonto',
        InvestmentType.investmentSavingsAccount =>
          'ISK (Investeringssparkonto)',
        InvestmentType.capitalInsurance => 'Kapitalförsäkring',
        InvestmentType.stocks => 'Aktier',
        InvestmentType.funds => 'Fonder',
        InvestmentType.bonds => 'Obligationer',
        InvestmentType.commodities => 'Råvaror',
        InvestmentType.realEstate => 'Fastigheter',
        InvestmentType.crowdfunding => 'Crowdfunding',
        InvestmentType.peerToPeerLending => 'Peer-to-peer-lån',
        InvestmentType.art => 'Konst',
        InvestmentType.jewelryAndGemstones => 'Smycken och ädelstenar',
        InvestmentType.wine => 'Vin',
        InvestmentType.collectibles => 'Samlarobjekt',
        InvestmentType.cryptocurrencies => 'Kryptovalutor',
        InvestmentType.nfts => 'NFT:er (Non-Fungible Tokens)',
        InvestmentType.greenBonds => 'Gröna obligationer',
        InvestmentType.sustainabilityFunds => 'Hållbarhetsfonder',
        InvestmentType.socialEnterprises => 'Sociala företag',
        InvestmentType.microfinancing => 'Mikrofinansiering',
        InvestmentType.pensionInsurance => 'Pensionsförsäkring',
        InvestmentType.childInsurance => 'Barnförsäkring',
        InvestmentType.lifeInsurance => 'Livförsäkring',
        InvestmentType.piggyBank => 'Spargris',
        InvestmentType.savingsChallenges => 'Sparutmaningar',
        InvestmentType.diyInvestments => '"Gör-det-själv"-investeringar',
      };

  String get description => switch (this) {
        InvestmentType.savingsAccount =>
          'Ett grundläggande konto med låg ränta, säkert för att spara pengar.',
        InvestmentType.highYieldSavingsAccount =>
          'Erbjuder högre ränta än ett vanligt sparkonto, men kan ha vissa villkor.',
        InvestmentType.fixedRateAccount =>
          'Pengarna låses in under en viss period till en fast ränta.',
        InvestmentType.investmentSavingsAccount =>
          'Konto för att investera i aktier och fonder, beskattas schablonmässigt.',
        InvestmentType.capitalInsurance =>
          'Liknar ISK, men med fler investeringsmöjligheter och förmånstagare.',
        InvestmentType.stocks =>
          'Köp andelar i företag, potential för hög avkastning men också risk.',
        InvestmentType.funds =>
          'En samling av olika värdepapper, diversifierar risken.',
        InvestmentType.bonds =>
          'Lån ut pengar till företag eller staten, får ränta i gengäld.',
        InvestmentType.commodities =>
          'Investera i guld, silver, olja etc., kan vara volatilt.',
        InvestmentType.realEstate =>
          'Köp hus eller lägenheter för att hyra ut eller sälja med vinst.',
        InvestmentType.crowdfunding =>
          'Investera i nya företag eller projekt via onlineplattformar.',
        InvestmentType.peerToPeerLending =>
          'Låna ut pengar direkt till andra privatpersoner via en plattform.',
        InvestmentType.art => 'Köp konstverk i hopp om att de ökar i värde.',
        InvestmentType.jewelryAndGemstones =>
          'Kan öka i värde över tid, särskilt om de är unika.',
        InvestmentType.wine =>
          'Investera i exklusiva viner som kan lagras och säljas senare.',
        InvestmentType.collectibles =>
          'Allt från frimärken till serietidningar kan bli värdefulla.',
        InvestmentType.cryptocurrencies =>
          'Digitala valutor som Bitcoin, hög risk och volatilitet.',
        InvestmentType.nfts =>
          'r (Non-Fungible Tokens): Unika digitala tillgångar, ofta kopplade till konst eller samlarobjekt.',
        InvestmentType.greenBonds => 'Finansierar miljövänliga projekt.',
        InvestmentType.sustainabilityFunds =>
          'Investerar i företag med fokus på ESG (miljö, socialt ansvar, bolagsstyrning).',
        InvestmentType.socialEnterprises =>
          'Investera i företag som har ett socialt eller miljömässigt syfte.',
        InvestmentType.microfinancing =>
          'Låna ut små summor till entreprenörer i utvecklingsländer.',
        InvestmentType.pensionInsurance =>
          'Sparande till pensionen med skattelättnader.',
        InvestmentType.childInsurance =>
          'Sparande till barn med förmånstagare.',
        InvestmentType.lifeInsurance => 'Ger utbetalning vid dödsfall.',
        InvestmentType.piggyBank =>
          'Traditionellt sätt att spara mynt och sedlar.',
        InvestmentType.savingsChallenges =>
          'Sätt upp mål och belöningar för att motivera sparandet.',
        InvestmentType.diyInvestments =>
          'Lär dig att investera på egen hand via aktiehandelsplattformar.',
      };
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
