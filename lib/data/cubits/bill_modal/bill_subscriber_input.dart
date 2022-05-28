import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/types.dart';

class BillSubscriberInput {
  int user;
  String amount;

  BillSubscriberInput({
    required this.user,
    required this.amount,
  });

  void setAmount(String amount) {
    this.amount = amount;
  }

  BillSubscriberInput.fromBillSubscriber(BillSubscriber subscriber)
      : user = subscriber.user,
        amount = subscriber.amount;

  JsonMap toAPIPayload() => {
        'user': user,
        'amount': amount,
      };
}
