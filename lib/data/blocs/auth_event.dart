import '../models/user_model.dart';

abstract class AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final String accessToken;
  final String refreshToken;
  final String firebaseId;
  final User user;

  UserLoggedIn({
    required this.accessToken,
    required this.refreshToken,
    required this.firebaseId,
    required this.user,
  });
}
