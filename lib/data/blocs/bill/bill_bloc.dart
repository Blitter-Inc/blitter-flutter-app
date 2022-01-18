import 'package:hydrated_bloc/hydrated_bloc.dart';
import './bill_event.dart';
import './bill_state.dart';

class BillBloc extends HydratedBloc<BillEvent, BillState> {
  BillBloc() : super(BillState()) {
    on<InitializeBillState>((event, emit) => emit(event.stateObj));
  }

  @override
  BillState fromJson(Map<String, dynamic> json) => BillState.fromCache(
        totalCount: json['totalCount']!,
        inStateCount: json['inStateCount']!,
        hasNext: json['hasNext']!,
        orderedSequence: json['orderedSequence']!,
        objectMap: json['objectMap']!,
        ordering: json['ordering']!,
        currentPage: json['currentPage']!,
        lastRefreshed: json['lastRefreshed']!,
      );

  @override
  Map<String, dynamic> toJson(BillState state) => {
        'totalCount': state.totalCount,
        'inStateCount': state.inStateCount,
        'lastRefreshed': state.lastRefreshed,
        'currentPage': state.currentPage,
        'hasNext': state.hasNext,
        'ordering': state.ordering,
        'orderedSequence': state.orderedSequence,
        'objectMap': state.objectMap?.map(
              (key, value) => MapEntry(key, value.toJson()),
            ) ??
            {},
      };
}
