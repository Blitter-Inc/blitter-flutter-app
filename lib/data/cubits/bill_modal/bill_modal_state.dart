import 'package:blitter_flutter_app/data/models.dart';

class BillModalState {
  Bill? bill;
  BillSubscriber? inTransactionBillSubscriber;
  String? inProcessingTransactionMode;

  BillModalState({
    this.bill,
    this.inTransactionBillSubscriber,
    this.inProcessingTransactionMode,
  });

  BillModalState copyWith({
    Bill? bill,
    BillSubscriber? inTransactionBillSubscriber,
    String? inProcessingTransactionMode,
  }) =>
      BillModalState(
        bill: bill ?? this.bill,
        inTransactionBillSubscriber:
            inTransactionBillSubscriber ?? this.inTransactionBillSubscriber,
        inProcessingTransactionMode: inProcessingTransactionMode ?? this.inProcessingTransactionMode,
      );
}
