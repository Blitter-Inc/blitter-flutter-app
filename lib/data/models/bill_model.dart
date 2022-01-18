import './bill_attachment_model.dart';
import './bill_subscriber_model.dart';

class Bill {
  final int id;
  final String name;
  final String amount;
  final String settledAmt;
  final String type;
  final String? eventName;
  final String description;
  final String status;
  final int createdBy;
  final List<BillSubscriber> subscribers;
  final List<BillAttachment> attachments;
  final String createdAt;
  final String lastUpdatedAt;

  const Bill({
    required this.id,
    required this.name,
    required this.amount,
    required this.settledAmt,
    required this.type,
    required this.eventName,
    required this.description,
    required this.status,
    required this.createdBy,
    required this.subscribers,
    required this.attachments,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  Bill.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        amount = json['amount'],
        settledAmt = json['settledAmt'],
        type = json['type'],
        eventName = json['eventName'],
        description = json['description'],
        status = json['status'],
        createdBy = json['createdBy'],
        subscribers = json['subscribers'],
        attachments = json['attachments'],
        createdAt = json['createdAt'],
        lastUpdatedAt = json['lastUpdatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
        'settledAmt': settledAmt,
        'type': type,
        'eventName': eventName,
        'description': description,
        'status': status,
        'createdBy': createdBy,
        'subscribers': subscribers,
        'attachments': attachments,
        'createdAt': createdAt,
        'lastUpdatedAt': lastUpdatedAt,
      };
}
