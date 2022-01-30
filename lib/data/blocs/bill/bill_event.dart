import 'package:blitter_flutter_app/data/models.dart';

abstract class BillEvent {}

class InitializeBillState extends BillEvent {
  InitializeBillState({required this.json});

  final Map<String, dynamic> json;
}

class RefreshBillState extends BillEvent {
  RefreshBillState({
    required this.json,
    this.callback,
  });

  final Map<String, dynamic> json;
  final Function? callback;
}

class AppendFetchedBills extends BillEvent {
  AppendFetchedBills({required this.objectMapJson});

  final Map<String, dynamic> objectMapJson;
}

class AddBill extends BillEvent {
  final Bill bill;

  AddBill(this.bill);
}

class UpdateBill extends BillEvent {
  final Bill bill;

  UpdateBill(this.bill);
}

class ResetBillBloc extends BillEvent {}
