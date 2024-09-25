import 'package:dart_mappable/dart_mappable.dart';

part 'bank_account.mapper.dart';

@MappableClass()
class BankAccount with BankAccountMappable {
  final double amount;
  final double interest;

  const BankAccount({
    required this.amount,
    this.interest = 0,
  });
}
