import 'package:http/http.dart' as http;

import 'package:blitter_flutter_app/config.dart' show apiBaseUrl;
import './types.dart';
import './abstract/api_repository.dart';

class ApiURI {
  static Uri _generateUri(
    String uri, {
    Map<String, dynamic> params = const {},
  }) {
    return Uri.https(apiBaseUrl, uri, params);
  }

  static Uri signIn() {
    return _generateUri('/user/login/');
  }

  static Uri updateUser() {
    return _generateUri('/user/update-profile/');
  }

  static Uri fetchUserProfiles() {
    return _generateUri('/user/fetch-profiles/');
  }

  static Uri fetchBills({Map<String, dynamic> params = const {}}) {
    return _generateUri('bill-manager/bill/', params: params);
  }

  static Uri createBill() {
    return _generateUri('bill-manager/bill/');
  }

  static Uri updateBill(String id) {
    return _generateUri('bill-manager/bill/$id/');
  }
}

class APIRepository extends IAPIRepository {
  @override
  Future<http.Response> signIn(RequestPayload payload) async {
    var response = await http.post(
      ApiURI.signIn(),
      body: payload,
    );
    return response;
  }

  @override
  Future<http.StreamedResponse> updateProfile(RequestPayload payload) async {
    var request =
        http.MultipartRequest('POST', ApiURI.updateBill(payload['id']))
          ..files.add(await http.MultipartFile.fromPath(
            'avatar',
            payload['avatar'],
            filename: payload['id'],
          ));
    payload.forEach((key, value) {
      if (key != 'id' || key != 'avatar') {
        request.fields[key] = value;
      }
    });
    var response = await request.send();
    return response;
  }

  @override
  Future<http.Response> fetchUserProfiles(RequestPayload payload) async {
    var response = await http.post(
      ApiURI.fetchUserProfiles(),
      body: payload,
    );
    return response;
  }
}
