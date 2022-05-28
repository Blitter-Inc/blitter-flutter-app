import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import 'package:blitter_flutter_app/data/types.dart';

class BillModalCubit extends Cubit<BillModalState> {
  final BillBloc billBloc;
  final APIRepository apiRepository;

  BillModalCubit({
    required this.billBloc,
    required this.apiRepository,
  }) : super(BillModalState());

  set bill(Bill? bill) => emit(state.copyWith(
        bill: bill,
      ));

  set inTransactionBillSubscriber(BillSubscriber? subscriber) =>
      emit(state.copyWith(
        inTransactionBillSubscriber: subscriber,
      ));

  Future<void> createBill({
    required BillModalInput input,
  }) async {
    final apiRes = await apiRepository.createBill(input.toAPIPayload());
    final newBillObject = Bill.fromAPIJson(jsonDecode(apiRes.body));
    billBloc.add(AddBill(newBillObject));
  }

  Future<void> updateBill({
    required int id,
    required BillModalInput input,
  }) async {
    final apiRes = await apiRepository.updateBill(id, input.toAPIPayload());
    final updatedBillObject = Bill.fromAPIJson(jsonDecode(apiRes.body));
    billBloc.add(UpdateBill(updatedBillObject));
  }

  Future<void> refreshBill({
    required int id,
  }) async {
    final apiRes = await apiRepository.fetchBill(id);
    final billObject = Bill.fromAPIJson(jsonDecode(apiRes.body));
    billBloc.add(UpdateBill(billObject));
  }

  Future<void> createTransaction(JsonMap payload) async {
    final res = await apiRepository.createTransaction(payload);
    debugPrint(res.body);
  }
}
