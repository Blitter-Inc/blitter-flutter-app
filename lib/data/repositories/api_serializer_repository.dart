import 'package:blitter_flutter_app/data/models.dart';
import '../types.dart';

class APISerializerRepository {
  Map<String, dynamic> _generateUserObject(body) {
    return {
      'id': body['id'],
      'name': body['name'],
      'email': body['email'],
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

  JsonMap fetchBillsResponseSerializer(JsonMap body) {
    return {
      'totalCount': body['count'],
      'currentPage': body['page'],
      'hasNext': body['next'] != null,
      'ordering': body['ordering'],
      'orderedSequence': (body['ordered_sequence'] as List).cast<int>(),
      'objectMap': (body['object_map'] as Map).map(
          (key, value) => MapEntry<String, Bill>(key, Bill.fromAPIJson(value))),
    };
  }

  JsonMap createBillRequestSerializer(JsonMap payload) {
    return {
      ...payload,
    };
  }

  Bill createBillResponseSerializer(JsonMap body) {
    return Bill.fromAPIJson(body);
  }

  JsonMap updateBillRequestSerializer(JsonMap payload) {
    return {
      ...payload,
      'subscribers': payload['subscribers'] ?? [],
    };
  }

  Bill updateBillResponseSerializer(JsonMap body) {
    return Bill.fromAPIJson(body);
  }
}
