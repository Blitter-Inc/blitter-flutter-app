class Transaction {
  final int id;
  final int sender;
  final int receiver;
  final String mode;
  final String amount;
  final String status;
  final String createdAt;
  final String lastUpdatedAt;

  const Transaction({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.mode,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sender = json['sender'],
        receiver = json['receiver'],
        mode = json['mode'],
        amount = json['amount'],
        status = json['status'],
        createdAt = json['createdAt'],
        lastUpdatedAt = json['lastUpdatedAt'];

  Transaction.fromAPIJson(Map<String, dynamic> json)
      : id = json['id'],
        sender = json['sender'],
        receiver = json['receiver'],
        mode = json['mode'],
        amount = json['amount'],
        status = json['status'],
        createdAt = json['created_at'],
        lastUpdatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'receiver': receiver,
        'mode': mode,
        'amount': amount,
        'status': status,
        'createdAt': createdAt,
        'lastUpdatedAt': lastUpdatedAt,
      };
}
