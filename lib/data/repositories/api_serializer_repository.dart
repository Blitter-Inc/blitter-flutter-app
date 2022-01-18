import './types.dart';

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

  Map<String, dynamic> _generateBillObject(body) {
    return {
      'id': body['id'],
      'name': body['name'],
      'amount': body['amount'],
      'settledAmt': body['settledAmt'],
      'type': body['type'],
      'eventName': body['eventName'],
      'description': body['description'],
      'status': body['status'],
      'createdBy': body['createdBy'],
      'subscribers':
          body['subscribers'].map((e) => _generateBillSubscriberObject(e)),
      'attachments':
          body['attachments'].map((e) => _generateBillAttachmentObject(e)),
      'createdAt': body['created_at'],
      'lastUpdatedAt': body['updated_at'],
    };
  }

  Map<String, dynamic> _generateBillSubscriberObject(body) {
    return {
      'id': body['id'],
      'userId': body['user'],
      'amount': body['amount'],
      'amountPaid': body['amount_paid'],
      'fulfilled': body['fulfilled'],
      'createdAt': body['created_at'],
      'lastUpdatedAt': body['updated_at'],
    };
  }

  Map<String, dynamic> _generateBillAttachmentObject(body) {
    return {
      'id': body['id'],
      'name': body['name'],
      'file': body['file'],
      'createdAt': body['created_at'],
      'lastUpdatedAt': body['updated_at'],
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

  JsonMap fetchUserProfilesResponseSerializer(JsonMap body) {
    return body.map((key, value) => MapEntry(key, _generateUserObject(value)));
  }

  JsonMap fetchBillsResponseSerializer(JsonMap body) {
    return {
      'totalCount': body['count'],
      'currentPage': body['page'],
      'hasNext': body['next'] != null,
      'ordering': body['ordering'],
      'orderedSequence': body['ordered_sequence'],
      'objectMap': body['object_map']
          .map((key, value) => MapEntry(key, _generateBillObject(value))),
    };
  }

  JsonMap createBillRequestSerializer(JsonMap payload) {
    return {
      ...payload,
    };
  }

  JsonMap createBillResponseSerializer(JsonMap body) {
    return _generateBillObject(body);
  }

  JsonMap updateBillRequestSerializer(JsonMap payload) {
    return {
      ...payload,
      'subscribers': payload['subscribers'] ?? [],
    };
  }

  JsonMap updateBillResponseSerializer(JsonMap body) {
    return _generateBillObject(body);
  }
}
