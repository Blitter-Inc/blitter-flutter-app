import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:blitter_flutter_app/data/models.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<UserLoggedIn>((event, emit) {
      emit(
        AuthState(
          accessToken: event.accessToken,
          refreshToken: event.refreshToken,
          firebaseId: event.firebaseId,
          user: event.user,
        ),
      );
    });
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) => AuthState(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        firebaseId: json['firebaseId'],
        user: User.fromJson(json['user']),
      );

  @override
  Map<String, dynamic> toJson(AuthState state) => {
        'accessToken': state.accessToken,
        'refreshToken': state.refreshToken,
        'firebaseId': state.firebaseId,
        'user': state.user?.toJson() ?? {},
      };
}
