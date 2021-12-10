import 'dart:convert';

import 'package:herbarium_mobile/src/core/constants/urls.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
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
        'Authorization': 'Bearer ${await _authenticationService.userToken}',
        'Content-Type': 'application/json'
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

  /// Retrieve all the [PlantType] available.
  /// Will throw an [HttpException] if the results of the request isn't successful.
  Future<List<PlantType>> getPlantTypes() async {
    final result = await _client.get(Uri.parse(Urls.getPlantTypes),
        headers: await _headers);

    if (result.statusCode >= 400) {
      _logger.e("$runtimeType - getPlantTypes - Failed ${result.statusCode}");
      throw HttpException(
          httpCode: result.statusCode,
          message: result.body,
          url: Urls.getPlantTypes);
    }

    final json = jsonDecode(result.body) as List<dynamic>;
    _logger.d("$runtimeType - getPlantTypes - ${result.statusCode}");

    return json
        .map((e) => PlantType.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Update a specified greenhouse details.
  Future updateGreenhouseDetails(String greenhouseUuid, String name) async {
    final result =
        await _client.post(Uri.parse(Urls.postUpdateGreenhouse(greenhouseUuid)),
            headers: await _headers,
            body: jsonEncode({
              'name': name,
            }));

    if (result.statusCode >= 400) {
      _logger.e(
          "$runtimeType - updateGreenhouseDetails - Failed ${result.statusCode}");
      throw HttpException(
          httpCode: result.statusCode,
          message: result.body,
          url: Urls.postUpdatePlantDetails(greenhouseUuid));
    }
  }

  /// Update a specified plant details.
  Future updatePlantDetails(String plantUuid, int? typeId,
      double? overrideMoistureGoal, double? overrideLightExposure) async {
    final result =
        await _client.post(Uri.parse(Urls.postUpdatePlantDetails(plantUuid)),
            headers: await _headers,
            body: jsonEncode({
              'type_id': typeId,
              'override_moisture_goal': overrideMoistureGoal,
              'override_light_exposure_min_duration': overrideLightExposure
            }));

    if (result.statusCode >= 400) {
      _logger
          .e("$runtimeType - updatePlantDetails - Failed ${result.statusCode}");
      throw HttpException(
          httpCode: result.statusCode,
          message: result.body,
          url: Urls.postUpdatePlantDetails(plantUuid));
    }
  }

  /// Delete the greenhouse [uuid] linked to the signed user.
  /// Will throw an [HttpException] if the results of the request isn't successful.
  Future deleteGreenhouse(String uuid) async {
    final result = await _client.delete(Uri.parse(Urls.deleteGreenhouse(uuid)),
        headers: await _headers);

    if (result.statusCode >= 400) {
      _logger
          .e("$runtimeType - deleteGreenhouse - Failed ${result.statusCode}");
      throw HttpException(
          httpCode: result.statusCode,
          message: result.body,
          url: Urls.getGreenhousesByUser);
    }
  }
}
