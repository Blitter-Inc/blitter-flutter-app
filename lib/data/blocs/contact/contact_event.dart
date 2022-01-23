import 'package:blitter_flutter_app/data/models.dart';
import './contact_state.dart';

abstract class ContactEvent {}

class InitializeContactState extends ContactEvent {
  final ContactState stateObj;

  InitializeContactState(Map<String, User> json)
      : stateObj = ContactState.fromFetchedData(
          objectMap: json,
        );
}

class ResetContactBloc extends ContactEvent {}
