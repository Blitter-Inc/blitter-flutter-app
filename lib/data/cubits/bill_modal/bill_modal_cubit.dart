import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import './bill_modal_input.dart';

class BillModalCubit extends Cubit {
  final BillBloc billBloc;
  final APIRepository apiRepository;

  BillModalCubit({
    required this.billBloc,
    required this.apiRepository,
  }) : super(null);

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
}
