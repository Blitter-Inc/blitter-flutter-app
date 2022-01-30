import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:blitter_flutter_app/utils/date_time.dart';
import './bill_event.dart';
import './bill_state.dart';

class BillBloc extends HydratedBloc<BillEvent, BillState> {
  BillBloc() : super(BillState()) {
    on<InitializeBillState>((event, emit) {
      emit(BillState.fromInitialCallJson(event.json));
    });

    on<RefreshBillState>((event, emit) {
      emit(state.copyWithRefreshCallJson(event.json));
    });

    on<AddBill>((event, emit) {
      emit(state.copyWith(
        totalCount: state.totalCount + 1,
        inStateCount: state.inStateCount + 1,
        orderedSequence: state.orderedSequence!..insert(0, event.bill.id),
        objectMap: state.objectMap!..[event.bill.id.toString()] = event.bill,
        lastModified: getCurrentDateTimeString(),
      ));
    });

    on<UpdateBill>((event, emit) {
      emit(state.copyWith(
        lastModified: getCurrentDateTimeString(),
        orderedSequence: state.orderedSequence!
          ..removeWhere((element) => element == event.bill.id)
          ..insert(0, event.bill.id),
        objectMap: state.objectMap!
          ..update(event.bill.id.toString(), (_) => event.bill),
      ));
    });

    on<ResetBillBloc>((_, emit) => emit(BillState()));
  }

  @override
  BillState fromJson(Map<String, dynamic> json) => BillState.fromJson(json);

  @override
  Map<String, dynamic> toJson(BillState state) => state.toJson(state);
}
