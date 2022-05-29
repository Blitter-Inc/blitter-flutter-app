class DashboardCounters {
  final int totalBillCount;
  final int totalTransactionCount;
  final int creditTransactionCount;
  final double creditTransactionAmount;
  final int debitTransactionCount;
  final double debitTransactionAmount;

  const DashboardCounters({
    required this.totalBillCount,
    required this.totalTransactionCount,
    required this.creditTransactionCount,
    required this.creditTransactionAmount,
    required this.debitTransactionCount,
    required this.debitTransactionAmount,
  });

  DashboardCounters.fromApiJson(Map<String, dynamic> json)
      : totalBillCount = json['total_bill_count'],
        totalTransactionCount = json['total_transaction_count'],
        creditTransactionCount = json['credit_transaction_count'],
        creditTransactionAmount = json['credit_transaction_amount'],
        debitTransactionCount = json['debit_transaction_count'],
        debitTransactionAmount = json['debit_transaction_amount'];
}
