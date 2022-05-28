import 'package:blitter_flutter_app/data/models.dart';
import '../types.dart';

class APISerializerRepository {
  Map<String, dynamic> _generateUserObject(body) {
    return {
      'id': body['id'],
      'name': body['name'],
      'email': body['email'],
      'upi': body['upi'],
      'bio': body['bio'],
      'avatar': body['avatar'],
      'phoneNumber': body['phone'],
      'dateJoined': body['date_joined'],
    };
  }

  JsonMap signInRequestSerializer(payload) {
    return {
      'phone': payload['phoneNumber'],
      'firebase_id': payload['firebaseId'],
    };
  }

  JsonMap signInResponseSerializer(body) {
    return {
      'accessToken': body['access_token'],
      'refreshToken': body['refresh_token'],
      'user': _generateUserObject(body['user']),
    };
  }

  JsonMap updateProfileResponseSerializer(body) {
    return _generateUserObject(body);
  }

  JsonMap fetchUserProfilesRequestSerializer(payload) {
    return {'phone_numbers': payload};
  }

  Map<String, User> fetchUserProfilesResponseSerializer(JsonMap body) {
    return body.map(
        (key, value) => MapEntry<String, User>(key, User.fromAPIJson(value)));
  }
}
