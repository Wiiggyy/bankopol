import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/investment.dart';

class Player {
  final String id;
  final String name;
  final BankAccount bankAccount;
  final List<Investment> investments;

  const Player({
    required this.id,
    required this.name,
    required this.bankAccount,
    required this.investments,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      bankAccount: BankAccount.fromJson(json['bankAccount']),
      investments: json['investments']
          .map<Investment>((investment) => Investment.fromJson(investment))
          .toList(),
    );
  }
  toJson() {
    return {
      'id': id,
      'name': name,
      'bankAccount': bankAccount.toJson(),
      'investments':
          investments.map((investment) => investment.toJson()).toList(),
    };
  }
}
