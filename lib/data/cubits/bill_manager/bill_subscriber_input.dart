import 'package:blitter_flutter_app/data/models.dart';

class BillSubscriberInput {
  final int user;
  final String amount;
  final int? id;
  final String? amountPaid;
  final bool? fulfilled;
  final String? createdAt;
  final String? lastUpdatedAt;

  const BillSubscriberInput({
    required this.user,
    required this.amount,
    this.id,
    this.amountPaid,
    this.fulfilled,
    this.createdAt,
    this.lastUpdatedAt,
  });

  BillSubscriberInput.fromBillSubscriber(BillSubscriber subscriber)
      : user = subscriber.user,
        amount = subscriber.amount,
        id = subscriber.id,
        amountPaid = subscriber.amountPaid,
        fulfilled = subscriber.fulfilled,
        createdAt = subscriber.createdAt,
        lastUpdatedAt = subscriber.lastUpdatedAt;
}
