import 'dart:convert';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/services/api_service.dart';
import 'package:herbarium_mobile/src/core/services/cache_service.dart';
import 'package:herbarium_mobile/src/core/utils/cache_exception.dart';
import 'package:logger/logger.dart';

class PlantTypesRepository {
  static const _plantTypesCacheKey = "plantTypes";

  final ApiService _apiService = locator<ApiService>();

  final CacheService _cacheService = locator<CacheService>();

  final Logger _logger = locator<Logger>();

  final List<PlantType> _plantTypes = [];

  /// Retrieve every [PlantType] available.
  Future<List<PlantType>> getPlantTypes({bool fromCacheOnly = false}) async {
    // Trying to retrieve from cache
    if (_plantTypes.isEmpty) {
      try {
        final List responseCache = jsonDecode(
            await _cacheService.get(_plantTypesCacheKey)) as List<dynamic>;
        _plantTypes.addAll(responseCache.map((e) => PlantType.fromJson(e)));
        _logger.d(
            "$runtimeType - getPlantTypes: ${_plantTypes.length} plant types from cache.");
      } on CacheException catch (_) {
        _logger.e(
            "$runtimeType - getPlantTypes: exception raised will trying to load plant types from cache.");
      }
    }

    if(fromCacheOnly) {
      return _plantTypes;
    }

    final fetchedPlantTypes = await _apiService.getPlantTypes();
    _logger.i(
        "$runtimeType - getPlantTypes fetched ${fetchedPlantTypes
            .length} plant types");

    _plantTypes.clear();
    _plantTypes.addAll(fetchedPlantTypes);
    // Update the cache
    _cacheService.update(_plantTypesCacheKey, jsonEncode(_plantTypes));

    return _plantTypes;
  }
}