import 'package:http/http.dart' as http;

import '../../types.dart';

abstract class IAPIRepository {
  Future<http.Response> signIn(JsonMap payload);

  Future<http.StreamedResponse> updateProfile(JsonMap payload);

  Future<http.Response> fetchUserProfiles(JsonMap payload);

  Future<http.Response> fetchBills({
    required String requestType,
    required String ordering,
    int? batchSize,
    String? lastRefreshed,
  });

  Future<http.Response> fetchRequestedBills(JsonMap payload);

  Future<http.Response> createBill(JsonMap payload);

  Future<http.Response> updateBill(int id, JsonMap payload);
}
