import 'package:blitter_flutter_app/data/types.dart';
import './contact_state.dart';

abstract class ContactEvent {}

class InitializeContactState extends ContactEvent {
  final ContactState stateObj;

  InitializeContactState(JsonMap json)
      : stateObj = ContactState.fromFetchedData(
          objectMap: json['objectMap']!,
        );
}

class ResetContactBloc extends ContactEvent {}
