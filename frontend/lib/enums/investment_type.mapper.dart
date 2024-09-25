// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'investment_type.dart';

class InvestmentTypeMapper extends EnumMapper<InvestmentType> {
  InvestmentTypeMapper._();

  static InvestmentTypeMapper? _instance;
  static InvestmentTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InvestmentTypeMapper._());
    }
    return _instance!;
  }

  static InvestmentType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  InvestmentType decode(dynamic value) {
    switch (value) {
      case 0:
        return InvestmentType.savingsAccount;
      case 1:
        return InvestmentType.highYieldSavingsAccount;
      case 2:
        return InvestmentType.fixedRateAccount;
      case 3:
        return InvestmentType.investmentSavingsAccount;
      case 4:
        return InvestmentType.capitalInsurance;
      case 5:
        return InvestmentType.stocks;
      case 6:
        return InvestmentType.funds;
      case 7:
        return InvestmentType.bonds;
      case 8:
        return InvestmentType.commodities;
      case 9:
        return InvestmentType.realEstate;
      case 10:
        return InvestmentType.crowdfunding;
      case 11:
        return InvestmentType.peerToPeerLending;
      case 12:
        return InvestmentType.art;
      case 13:
        return InvestmentType.jewelryAndGemstones;
      case 14:
        return InvestmentType.wine;
      case 15:
        return InvestmentType.collectibles;
      case 16:
        return InvestmentType.cryptocurrencies;
      case 17:
        return InvestmentType.nfts;
      case 18:
        return InvestmentType.greenBonds;
      case 19:
        return InvestmentType.sustainabilityFunds;
      case 20:
        return InvestmentType.socialEnterprises;
      case 21:
        return InvestmentType.microfinancing;
      case 22:
        return InvestmentType.pensionInsurance;
      case 23:
        return InvestmentType.childInsurance;
      case 24:
        return InvestmentType.lifeInsurance;
      case 25:
        return InvestmentType.piggyBank;
      case 26:
        return InvestmentType.savingsChallenges;
      case 27:
        return InvestmentType.diyInvestments;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(InvestmentType self) {
    switch (self) {
      case InvestmentType.savingsAccount:
        return 0;
      case InvestmentType.highYieldSavingsAccount:
        return 1;
      case InvestmentType.fixedRateAccount:
        return 2;
      case InvestmentType.investmentSavingsAccount:
        return 3;
      case InvestmentType.capitalInsurance:
        return 4;
      case InvestmentType.stocks:
        return 5;
      case InvestmentType.funds:
        return 6;
      case InvestmentType.bonds:
        return 7;
      case InvestmentType.commodities:
        return 8;
      case InvestmentType.realEstate:
        return 9;
      case InvestmentType.crowdfunding:
        return 10;
      case InvestmentType.peerToPeerLending:
        return 11;
      case InvestmentType.art:
        return 12;
      case InvestmentType.jewelryAndGemstones:
        return 13;
      case InvestmentType.wine:
        return 14;
      case InvestmentType.collectibles:
        return 15;
      case InvestmentType.cryptocurrencies:
        return 16;
      case InvestmentType.nfts:
        return 17;
      case InvestmentType.greenBonds:
        return 18;
      case InvestmentType.sustainabilityFunds:
        return 19;
      case InvestmentType.socialEnterprises:
        return 20;
      case InvestmentType.microfinancing:
        return 21;
      case InvestmentType.pensionInsurance:
        return 22;
      case InvestmentType.childInsurance:
        return 23;
      case InvestmentType.lifeInsurance:
        return 24;
      case InvestmentType.piggyBank:
        return 25;
      case InvestmentType.savingsChallenges:
        return 26;
      case InvestmentType.diyInvestments:
        return 27;
    }
  }
}

extension InvestmentTypeMapperExtension on InvestmentType {
  dynamic toValue() {
    InvestmentTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<InvestmentType>(this);
  }
}
