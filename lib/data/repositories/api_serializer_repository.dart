typedef Request = Map<String, dynamic>;
typedef Response = Map<String, dynamic>;

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

  Request signInRequestSerializer(payload) {
    return {
      'phone': payload['phoneNumber'],
      'firebase_id': payload['firebaseId'],
    };
  }

  Response signInResponseSerializer(body) {
    return {
      'accessToken': body['access_token'],
      'refreshToken': body['refresh_token'],
      'user': _generateUserObject(body['user']),
    };
  }

  Response updateProfileResponseSerializer(body) {
    return _generateUserObject(body);
  }

  Request fetchUserProfilesRequestSerializer(payload) {
    return {'phone_numbers': payload};
  }

  Response fetchUserProfilesResponseSerializer(Map body) {
    return body.map((key, value) => MapEntry(key, _generateUserObject(value)));
  }
}
