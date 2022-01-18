import 'package:http/http.dart' as http;

import 'package:blitter_flutter_app/config.dart' show apiBaseUrl;
import 'package:blitter_flutter_app/data/blocs.dart' show AuthState;
import '../types.dart';
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

  static Uri updateBill(int id) {
    return _generateUri('bill-manager/bill/$id/');
  }
}

class APIRepository extends IAPIRepository {
  final AuthState authState;

  APIRepository({
    required this.authState,
  });

  Map<String, String> _getAuthHeaders() {
    return {
      'Authorization': 'Bearer ${authState.accessToken}',
    };
  }

  @override
  Future<http.Response> signIn(JsonMap payload) async {
    var response = await http.post(
      ApiURI.signIn(),
      body: payload,
    );
    return response;
  }

  @override
  Future<http.StreamedResponse> updateProfile(JsonMap payload) async {
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
  Future<http.Response> fetchUserProfiles(JsonMap payload) async {
    var response = await http.post(
      ApiURI.fetchUserProfiles(),
      body: payload,
    );
    return response;
  }

  @override
  Future<http.Response> fetchBills() async {
    var response = await http.get(
      ApiURI.fetchBills(),
      headers: _getAuthHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> createBill(JsonMap payload) async {
    var response = await http.post(
      ApiURI.createBill(),
      headers: _getAuthHeaders(),
      body: payload,
    );
    return response;
  }

  @override
  Future<http.Response> updateBill(int id, JsonMap payload) async {
    var response = await http.patch(
      ApiURI.updateBill(id),
      headers: _getAuthHeaders(),
      body: payload,
    );
    return response;
  }
}
