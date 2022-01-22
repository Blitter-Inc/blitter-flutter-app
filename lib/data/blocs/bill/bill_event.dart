import 'package:blitter_flutter_app/data/types.dart';
import './bill_state.dart';

abstract class BillEvent {}

class InitializeBillState extends BillEvent {
  final BillState stateObj;

  InitializeBillState(JsonMap json)
      : stateObj = BillState.fromFetchedData(
          totalCount: json['totalCount']!,
          inStateCount: json['orderedSequence']!.length,
          hasNext: json['hasNext']!,
          orderedSequence: json['orderedSequence']!,
          objectMap: json['objectMap']!,
        );
}

class ResetBillBloc extends BillEvent {}
