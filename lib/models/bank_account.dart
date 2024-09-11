class BankAccount {
  final double amount;
  final double interest;

  const BankAccount({
    required this.amount,
    this.interest = 0,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      amount: json['amount'],
      interest: json['interest'],
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

  toJson() {
    return {
      'amount': amount,
      'interest': interest,
    };
  }
}
