class BankAccount {
  final double amount;
  final double interest;

  const BankAccount({
    required this.amount,
    this.interest = 0,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      amount: (json['amount'] as num).toDouble(),
      interest: (json['interest'] as num).toDouble(),
    );
  }

  BankAccount copyWith({
    double? amount,
    double? interest,
  }) {
    return BankAccount(
      amount: amount ?? this.amount,
      interest: interest ?? this.interest,
    );
  }

  Map<String, double> toJson() {
    return {
      'amount': amount,
      'interest': interest,
    };
  }
}
