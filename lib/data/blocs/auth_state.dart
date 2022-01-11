import '../models.dart';

class AuthState {
  String? accessToken;
  String? refreshToken;
  String? firebaseId;
  User? user;

  AuthState({
    this.accessToken,
    this.refreshToken,
    this.firebaseId,
    this.user,
  });

  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    String? firebaseId,
    User? user,
  }) =>
      AuthState(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        firebaseId: firebaseId ?? this.firebaseId,
        user: user ?? this.user,
      );
}
