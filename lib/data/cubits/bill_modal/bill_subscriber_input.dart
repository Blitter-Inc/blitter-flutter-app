import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/types.dart';

class BillSubscriberInput {
  final int user;
  final String amount;

  const BillSubscriberInput({
    required this.user,
    required this.amount,
  });

  BillSubscriberInput.fromBillSubscriber(BillSubscriber subscriber)
      : user = subscriber.user,
        amount = subscriber.amount;

  JsonMap toAPIPayload() => {
        'user': user,
        'amount': amount,
      };
}
