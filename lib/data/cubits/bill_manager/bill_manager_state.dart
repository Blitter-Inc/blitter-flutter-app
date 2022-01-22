import './bill_modal_state.dart';

class BillManagerState {
  final BillModalState? billModalState;
  const BillManagerState({
    this.billModalState,
  });

  BillManagerState copyWith({
    BillModalState? billModalState,
  }) =>
      BillManagerState(
        billModalState: billModalState ?? this.billModalState,
      );
}
