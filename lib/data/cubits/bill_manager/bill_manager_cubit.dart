import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/models.dart';
import './bill_manager_state.dart';
import './bill_modal_state.dart';

class BillManagerCubit extends Cubit<BillManagerState> {
  BillManagerCubit() : super(const BillManagerState());

  void setBillModalInput(Bill bill) {
    emit(state.copyWith(
      billModalState: BillModalState.fromBill(bill),
    ));
  }
}
