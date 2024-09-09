import 'dart:convert';
import 'package:challenge/core/failures/failure.dart';
import 'package:http/http.dart' as http;

abstract class HttpServiceBase {
  Future<List<dynamic>> get({
    required String url,
    Map<String, String>? headers,
  });
}

class HttpService extends HttpServiceBase {
  final http.Client httpClient;

  HttpService({required this.httpClient});

  @override
  Future<List<dynamic>> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    final response = await httpClient.get(
      Uri.parse(url),
      headers: headers,
    );

    _checkStatusCode(response.statusCode, response.body);

    return jsonDecode(response.body) as List<dynamic>;
  }

  void _checkStatusCode(int statusCode, String body) {
    if (statusCode == 200) return;

    throw UnhandledFailure(message: body);
  }
}
