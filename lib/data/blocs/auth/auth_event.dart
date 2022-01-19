import 'package:blitter_flutter_app/data/models.dart';

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

  UserLoggedIn.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        firebaseId = json['firebaseId'],
        user = User.fromJson(json['user']);
}

class UserProfileUpdated extends AuthEvent {
  final User user;

  UserProfileUpdated({
    required this.user,
  });

  UserProfileUpdated.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json);
}
