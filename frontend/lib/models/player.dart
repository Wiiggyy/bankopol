import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/investment.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'player.mapper.dart';

@MappableClass()
class Player with PlayerMappable {
  final String id;
  final String name;
  final BankAccount bankAccount;
  final List<Investment> investments;
  final Set<int> scannedCodes;

  const Player({
    required this.id,
    required this.name,
    required this.bankAccount,
    required this.investments,
    this.scannedCodes = const {},
  });

  double get totalAssetsValue {
    return investments.fold(
      bankAccount.amount,
      (previousValue, element) => previousValue + element.value,
    );
  }
}
