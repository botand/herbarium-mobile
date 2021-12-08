import 'dart:convert';

import 'package:herbarium_mobile/src/core/constants/urls.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/services/authentication_service.dart';
import 'package:herbarium_mobile/src/core/utils/http_exception.dart';
import 'package:http/http.dart';

import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:logger/logger.dart';

class ApiService {
  final Logger _logger = locator<Logger>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  late final Client _client;

  ApiService({Client? client}) {
    _client = client ?? Client();
  }

  Future<Map<String, String>> get _headers async => {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await _authenticationService.userToken}'
      };

  /// Retrieve every greenhouses linked to the signed user.
  /// Will throw an [HttpException] if the results of the request isn't successful.
  Future<List<Greenhouse>> getGreenhouses() async {
    final result = await _client.get(Uri.parse(Urls.getGreenhousesByUser),
        headers: await _headers);

    if (result.statusCode >= 400) {
      _logger.e("$runtimeType - getGreenhouses - Failed ${result.statusCode}");
      throw HttpException(
          httpCode: result.statusCode,
          message: result.body,
          url: Urls.getGreenhousesByUser);
    }

    final json = jsonDecode(result.body) as List<dynamic>;
    _logger.d("$runtimeType - getGreenhouses - ${result.statusCode}");

    return json
        .map((e) => Greenhouse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
