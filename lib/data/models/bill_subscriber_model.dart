class BillSubscriber {
  final int id;
  final int user;
  final String amount;
  final String amountPaid;
  final bool fulfilled;
  final String createdAt;
  final String lastUpdatedAt;

  const BillSubscriber({
    required this.id,
    required this.user,
    required this.amount,
    required this.amountPaid,
    required this.fulfilled,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  BillSubscriber.fromJson(Map<String, dynamic> json)
      : id = json['id']!,
        user = json['user']!,
        amount = json['amount']!,
        amountPaid = json['amountPaid']!,
        fulfilled = json['fulfilled']!,
        createdAt = json['createdAt']!,
        lastUpdatedAt = json['lastUpdatedAt']!;

  BillSubscriber.fromAPIJson(Map<String, dynamic> json)
      : id = json['id']!,
        user = json['user']!,
        amount = json['amount']!,
        amountPaid = json['amount_paid']!,
        fulfilled = json['fulfilled']!,
        createdAt = json['created_at']!,
        lastUpdatedAt = json['updated_at']!;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'amount': amount,
        'amountPaid': amountPaid,
        'fulfilled': fulfilled,
        'createdAt': createdAt,
        'lastUpdatedAt': lastUpdatedAt,
      };
}
