import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
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
    apiRepository.createBill(input.toAPIPayload());
  }

  Future<void> updateBill({
    required int id,
    required BillModalInput input,
  }) async {
    apiRepository.updateBill(id, input.toAPIPayload());
  }
}
