import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:blitter_flutter_app/config.dart' show apiBaseUrl;
import 'package:blitter_flutter_app/data/blocs.dart' show AuthState;
import 'package:blitter_flutter_app/data/constants.dart';
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

  static Uri addUpi() {
    return _generateUri('/user/upi/add/');
  }

  static Uri fetchUserProfiles() {
    return _generateUri('/user/fetch-profiles/');
  }

  static Uri createTransaction() {
    return _generateUri('user/transaction/add/');
  }

  static Uri fetchCounters() {
    return _generateUri('user/fetch-counters/');
  }

  static Uri fetchTransactions() {
    return _generateUri('user/transaction/');
  }

  static Uri fetchBills({Map<String, dynamic> params = const {}}) {
    return _generateUri('bill-manager/bill/fetch/', params: params);
  }

  static Uri fetchBill(int billId) {
    return _generateUri('bill-manager/bill/$billId');
  }

  static Uri fetchRequestedBills() {
    return _generateUri('bill-manager/bill/fetch-requested/');
  }

  static Uri createBill() {
    return _generateUri('bill-manager/bill/');
  }

  static Uri updateBill(int id) {
    return _generateUri('bill-manager/bill/$id/');
  }
}

class APIRepository extends IAPIRepository {
  AuthState _authState;

  APIRepository({required AuthState authState}) : _authState = authState;

  set authState(AuthState state) {
    _authState = state;
  }

  Map<String, String> _getAuthHeaders() {
    return {
      'Authorization': 'Bearer ${_authState.accessToken}',
    };
  }

  Map<String, String> _getHeaders() {
    return {
      ..._getAuthHeaders(),
      'Content-type': 'application/json',
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
    var request = http.MultipartRequest('PATCH', ApiURI.updateUser())
      ..headers.addAll(_getAuthHeaders());
    if (payload['avatar'] != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        payload['avatar'],
        filename: payload['id'],
      ));
    }
    payload.forEach((key, value) {
      if (key != 'id' && key != 'avatar') {
        request.fields[key] = value;
      }
    });
    var response = await request.send();
    return response;
  }

  @override
  Future<http.Response> addUpi(JsonMap payload) async {
    var response = await http.post(
      ApiURI.addUpi(),
      body: jsonEncode(payload),
      headers: _getHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> fetchUserProfiles(JsonMap payload) async {
    var response = await http.post(
      ApiURI.fetchUserProfiles(),
      body: jsonEncode(payload),
      headers: _getHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> fetchCounters() async {
    var response = await http.get(
      ApiURI.fetchCounters(),
      headers: _getHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> fetchTransactions() async {
    var response = await http.get(
      ApiURI.fetchTransactions(),
      headers: _getHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> fetchBills({
    required String requestType,
    required String ordering,
    int? batchSize,
    String? lastRefreshed,
    Map<String, dynamic>? params,
  }) async {
    params ??= <String, dynamic>{};
    var response = await http.get(
      ApiURI.fetchBills(
        params: {
          'request_type': requestType,
          'ordering': ordering,
          ...(requestType == FetchAPIRequestType.initial)
              ? {'batch_size': batchSize.toString()}
              : {},
          ...(requestType == FetchAPIRequestType.refresh)
              ? {'last_refreshed': lastRefreshed}
              : {},
          ...params,
        },
      ),
      headers: _getAuthHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> fetchBill(int id) async {
    var response = await http.get(
      ApiURI.fetchBill(id),
      headers: _getAuthHeaders(),
    );
    return response;
  }

  @override
  Future<http.Response> fetchRequestedBills(JsonMap payload) async {
    var response = await http.post(
      ApiURI.fetchRequestedBills(),
      headers: _getHeaders(),
      body: jsonEncode(payload),
    );
    return response;
  }

  @override
  Future<http.Response> createBill(JsonMap payload) async {
    var response = await http.post(
      ApiURI.createBill(),
      headers: _getHeaders(),
      body: jsonEncode(payload),
    );
    return response;
  }

  @override
  Future<http.Response> updateBill(int id, JsonMap payload) async {
    var response = await http.patch(
      ApiURI.updateBill(id),
      headers: _getHeaders(),
      body: jsonEncode(payload),
    );
    return response;
  }

  @override
  Future<http.Response> createTransaction(JsonMap payload) async {
    var response = await http.post(
      ApiURI.createTransaction(),
      headers: _getHeaders(),
      body: jsonEncode(payload),
    );
    return response;
  }
}
