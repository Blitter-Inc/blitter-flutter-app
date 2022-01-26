import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:blitter_flutter_app/data/models.dart';
import './bill_event.dart';
import './bill_state.dart';

class BillBloc extends HydratedBloc<BillEvent, BillState> {
  BillBloc() : super(BillState()) {
    on<InitializeBillState>((event, emit) {
      emit(event.stateObj);
    });

    on<AddBill>((event, emit) {
      emit(state.copyWith(
        totalCount: state.totalCount + 1,
        inStateCount: state.inStateCount + 1,
        lastModified: DateTime.now().toString(),
        orderedSequence: state.orderedSequence!..insert(0, event.bill.id),
        objectMap: state.objectMap!..[event.bill.id.toString()] = event.bill,
      ));
    });

    on<UpdateBill>((event, emit) {
      emit(state.copyWith(
        lastModified: DateTime.now().toString(),
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
  BillState fromJson(Map<String, dynamic> json) => BillState.fromCache(
        totalCount: json['totalCount']!,
        inStateCount: json['inStateCount']!,
        hasNext: json['hasNext'],
        orderedSequence: json['orderedSequence'],
        objectMap: (json['objectMap'] as Map).map(
          (key, value) => MapEntry<String, Bill>(key, Bill.fromJson(value)),
        ),
        ordering: json['ordering'],
        currentPage: json['currentPage'],
        lastRefreshed: json['lastRefreshed'],
        lastModified: json['lastModified'],
      );

  @override
  Map<String, dynamic> toJson(BillState state) => {
        'totalCount': state.totalCount,
        'inStateCount': state.inStateCount,
        'lastRefreshed': state.lastRefreshed,
        'lastModified': state.lastModified,
        'currentPage': state.currentPage,
        'hasNext': state.hasNext,
        'ordering': state.ordering,
        'orderedSequence': state.orderedSequence,
        'objectMap': state.objectMap?.map(
              (key, value) => MapEntry<String, dynamic>(key, value.toJson()),
            ) ??
            {},
      };
}
