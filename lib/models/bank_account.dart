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

  toJson() {
    return {
      'amount': amount,
      'interest': interest,
    };
  }
}
