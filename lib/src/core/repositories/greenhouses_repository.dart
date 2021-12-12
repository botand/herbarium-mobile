import 'dart:convert';

import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/services/api_service.dart';
import 'package:herbarium_mobile/src/core/services/cache_service.dart';
import 'package:herbarium_mobile/src/core/utils/cache_exception.dart';
import 'package:herbarium_mobile/src/core/utils/http_exception.dart';
import 'package:logger/logger.dart';

class GreenhousesRepository {
  static const _greenhousesCacheKey = "greenhouses";

  final ApiService _apiService = locator<ApiService>();

  final CacheService _cacheService = locator<CacheService>();

  final Logger _logger = locator<Logger>();

  final List<Greenhouse> _greenhouses = [];

  List<Greenhouse> get greenhouses => _greenhouses;

  /// Retrieve all the greenhouses of the connected user. Using the flag [fromCacheOnly]
  /// will not fetch data from the API.
  Future<List<Greenhouse>> getGreenhouses({fromCacheOnly = false}) async {
    // Trying to retrieve from cache
    if (_greenhouses.isEmpty) {
      try {
        final List responseCache =
            jsonDecode(await _cacheService.get(_greenhousesCacheKey))
                as List<dynamic>;
        _greenhouses.addAll(responseCache.map((e) => Greenhouse.fromJson(e)));
        _logger.d(
            "$runtimeType - getGreenhouses: ${_greenhouses.length} greenhouses from cache.");
      } on CacheException catch (_) {}
    }

    if (fromCacheOnly) {
      return _greenhouses;
    }

    final fetchedGreenhouses = await _apiService.getGreenhouses();
    _logger.i(
        "$runtimeType - getGreenhouses fetched ${fetchedGreenhouses.length} greenhouses");

    _greenhouses.clear();
    _greenhouses.addAll(fetchedGreenhouses);
    // Update the cache
    _cacheService.update(_greenhousesCacheKey, jsonEncode(_greenhouses));

    return _greenhouses;
  }

  /// Update the [greenhouse] in the database.
  Future<bool> updateGreenhouse(Greenhouse greenhouse) async {
    try {
      _logger.d(
          "$runtimeType - updateGreenhouse: start update greenhouse ${greenhouse.uuid}");
      await _apiService.updateGreenhouseDetails(
          greenhouse.uuid, greenhouse.name);
    } on HttpException catch (_) {
      _logger.e("$runtimeType - updateGreenhouse: failed");
      return false;
    }

    try {
      _logger.d("$runtimeType - updateGreenhouse: update greenhouses list");
      await getGreenhouses();
    } on HttpException catch (_) {
      _logger
          .e("$runtimeType - updateGreenhouse: update greenhouses list failed");
    }
    return true;
  }

  /// Delete the [greenhouse] from the database.
  Future<bool> deleteGreenhouse(Greenhouse greenhouse) async {
    try {
      _logger.d(
          "$runtimeType - deleteGreenhouse: start deletion of greenhouse ${greenhouse.uuid}");
      await _apiService.deleteGreenhouse(greenhouse.uuid);
    } on HttpException catch (_) {
      _logger.e("$runtimeType - deleteGreenhouse: failed");
      return false;
    }

    try {
      _logger.d("$runtimeType - deleteGreenhouse: update greenhouses list");
      await getGreenhouses();
    } on HttpException catch (_) {
      _logger
          .e("$runtimeType - deleteGreenhouse: update greenhouses list failed");
    }
    return true;
  }

  /// Update the [plant] in the database.
  Future<bool> updatePlant(Plant plant, {bool moved = false}) async {
    try {
      _logger.d("$runtimeType - updatePlant: start update plant ${plant.uuid}");
      await _apiService.updatePlantDetails(
          plant.uuid,
          plant.type.id,
          plant.overrideMoistureGoal,
          plant.overrideLightExposureMinDuration,
          moved ? plant.position : null);
    } on HttpException catch (_) {
      _logger.e("$runtimeType - updatePlant: failed");
      return false;
    }

    try {
      _logger.d("$runtimeType - updatePlant: update greenhouses list");
      getGreenhouses();
    } on HttpException catch (_) {
      _logger.e("$runtimeType - updatePlant: update greenhouses list failed");
    }
    return true;
  }

  /// Link the current user with the [uuid] greenhouse and name it.
  Future<bool> registerGreenhouse(String uuid, String name) async {
    try {
      await _apiService.registerGreenhouse(uuid, name);
    } on HttpException catch (_) {
      _logger.e("$runtimeType - registerGreenhouse: failed");
      return false;
    }

    try {
      _logger.d("$runtimeType - registerGreenhouse: update greenhouses list");
      getGreenhouses();
    } on HttpException catch (_) {
      _logger.e(
          "$runtimeType - registerGreenhouse: update greenhouses list failed");
    }
    return true;
  }
}
