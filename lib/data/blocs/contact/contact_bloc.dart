import 'package:blitter_flutter_app/data/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import './contact_event.dart';
import './contact_state.dart';

class ContactBloc extends HydratedBloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState()) {
    on<InitializeContactState>((event, emit) {
      emit(event.stateObj);
    });
    on<ResetContactBloc>((_, emit) => emit(ContactState()));
  }

  @override
  ContactState fromJson(Map<String, dynamic> json) => ContactState.fromCache(
      lastRefreshed: json['lastRefreshed'],
      objectMap: (json['objectMap'] as Map).map(
          (key, value) => MapEntry<String, User>(key, User.fromJson(value))),
      totalCount: json['totalCount']);

  @override
  Map<String, dynamic> toJson(ContactState state) => {
        'totalCount': state.totalCount,
        'lastRefreshed': state.lastRefreshed,
        'objectMap': state.objectMap?.map(
              (key, value) => MapEntry<String, dynamic>(key, value.toJson()),
            ) ??
            {},
      };

  User? getUserById(int id) => state.objectMap![id.toString()];
}
