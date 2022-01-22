import 'package:blitter_flutter_app/data/models.dart';

import './bill_attachment_input.dart';
import './bill_subscriber_input.dart';

class BillModalState {
  final String name;
  final String amount;
  final String type;
  final String description;
  final List<BillSubscriberInput> subscribers;
  final List<BillAttachmentInput> attachments;

  final int? id;
  final String? settledAmt;
  final String? status;
  final String? eventName;
  final int? createdBy;
  final String? createdAt;
  final String? lastUpdatedAt;

  const BillModalState({
    required this.name,
    required this.amount,
    required this.type,
    required this.description,
    this.subscribers = const [],
    this.attachments = const [],
    this.id,
    this.settledAmt,
    this.status,
    this.eventName,
    this.createdBy,
    this.createdAt,
    this.lastUpdatedAt,
  });

  BillModalState.fromBill(Bill bill)
      : name = bill.name,
        amount = bill.amount,
        type = bill.type,
        description = bill.description,
        id = bill.id,
        settledAmt = bill.settledAmt,
        status = bill.status,
        eventName = bill.eventName,
        createdBy = bill.createdBy,
        createdAt = bill.createdAt,
        lastUpdatedAt = bill.lastUpdatedAt,
        subscribers = bill.subscribers
            .map((e) => BillSubscriberInput.fromBillSubscriber(e))
            .toList(),
        attachments = bill.attachments
            .map((e) => BillAttachmentInput.fromBillAttachment(e))
            .toList();

  BillModalState copyWith({
    String? name,
    String? amount,
    String? type,
    String? description,
    List<BillSubscriberInput>? subscribers,
    List<BillAttachmentInput>? attachments,
    int? id,
    String? settledAmt,
    String? status,
    String? eventName,
    int? createdBy,
    String? createdAt,
    String? lastUpdatedAt,
  }) =>
      BillModalState(
        name: name ?? this.name,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        description: description ?? this.description,
        subscribers: subscribers ?? this.subscribers,
        attachments: attachments ?? this.attachments,
        id: id ?? this.id,
        settledAmt: settledAmt ?? this.settledAmt,
        status: status ?? this.status,
        eventName: eventName ?? this.eventName,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      );
}
