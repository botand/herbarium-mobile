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

  /// Update the [plant] in the database.
  Future<bool> updatePlant(Plant plant) async {
    try {
      _logger.d("$runtimeType - updatePlant: start update plant ${plant.uuid}");
      await _apiService.updatePlantDetails(plant.uuid, plant.type.id,
          plant.overrideMoistureGoal, plant.overrideLightExposureMinDuration);
    } on HttpException catch (_) {
      _logger.e("$runtimeType - updatePlant: failed");
      return false;
    }

    try {
      _logger.d("$runtimeType - updatePlant: update greenhouses list");
      getGreenhouses();
    } on HttpException catch(_) {
      _logger.e("$runtimeType - updatePlant: update greenhouses list failed");
    }
    return true;
  }
}
