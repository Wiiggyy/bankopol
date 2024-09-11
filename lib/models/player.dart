import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/investment.dart';

class Player {
  final String id;
  final String name;
  final BankAccount bankAccount;
  final Set<Investment> investments;
  final Set<int> scannedCodes;

  const Player({
    required this.id,
    required this.name,
    required this.bankAccount,
    required this.investments,
    this.scannedCodes = const {},
  });

  double get totalAssetsValue {
    return investments.fold(bankAccount.amount,
        (previousValue, element) => previousValue + element.value);
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      bankAccount: BankAccount.fromJson(json['bankAccount']),
      investments: json['investments']
          .map<Investment>((investment) => Investment.fromJson(investment))
          .toSet(),
    );
  }

  Player copyWith({
    String? id,
    String? name,
    BankAccount? bankAccount,
    Set<Investment>? investments,
    Set<int>? scannedCodes,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      bankAccount: bankAccount ?? this.bankAccount,
      investments: investments ?? this.investments,
      scannedCodes: scannedCodes ?? this.scannedCodes,
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'bankAccount': bankAccount.toJson(),
      'investments':
          investments.map((investment) => investment.toJson()).toList(),
      'scannedCodes': scannedCodes.toList(),
    };
  }
}
