import 'package:herbarium_mobile/src/core/constants/urls.dart';
import 'package:herbarium_mobile/src/core/services/authentication_service.dart';
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

  Future<List<Greenhouse>> getGreenhouses() async {
    final result = await _client.get(Uri.parse(Urls.getGreenhousesByUser),
        headers: await _headers);

    _logger.i("Data received: ${result.statusCode}");
    return true;
  }
}
