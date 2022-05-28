import 'package:blitter_flutter_app/data/models.dart';

class BillModalState {
  Bill? bill;
  BillSubscriber? inTransactionBillSubscriber;

  BillModalState({
    this.bill,
    this.inTransactionBillSubscriber,
  });

  BillModalState copyWith({
    Bill? bill,
    BillSubscriber? inTransactionBillSubscriber,
  }) =>
      BillModalState(
        bill: bill ?? this.bill,
        inTransactionBillSubscriber:
            inTransactionBillSubscriber ?? this.inTransactionBillSubscriber,
      );
}
