import 'package:http/http.dart' as http;

import '../types.dart';

abstract class IAPIRepository {
  Future<http.Response> signIn(RequestPayload payload);

  Future<http.StreamedResponse> updateProfile(RequestPayload payload);

  Future<http.Response> fetchUserProfiles(RequestPayload payload);
}
