import 'dart:convert';

import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/services/api_service.dart';
import 'package:herbarium_mobile/src/core/services/cache_service.dart';
import 'package:herbarium_mobile/src/core/utils/cache_exception.dart';
import 'package:logger/logger.dart';

class GreenhousesRepository {
  static const _greenhousesCacheKey = "greenhouses";

  final ApiService _apiService = locator<ApiService>();

  final CacheService _cacheService = locator<CacheService>();

  final Logger _logger = locator<Logger>();

  final List<Greenhouse> _greenhouses = [];

  List<Greenhouse> get greenhouses => _greenhouses;

  Future<List<Greenhouse>> getGreenhouses({fromCacheOnly = false}) async {
    // Trying to retrieve from cache
    if (_greenhouses.isEmpty) {
      try {
        final List responseCache = jsonDecode(
            await _cacheService.get(_greenhousesCacheKey)) as List<dynamic>;
        _greenhouses.addAll(responseCache.map((e) => Greenhouse.fromJson(e)));
        _logger.d(
            "$runtimeType - getGreenhouses: ${_greenhouses.length} greenhouses from cache.");
      } on CacheException catch (_) {}
    }

    if(fromCacheOnly) {
      return _greenhouses;
    }

    final fetchedGreenhouses = await _apiService.getGreenhouses();
    _logger.i(
        "$runtimeType - getGreenhouses fetched ${fetchedGreenhouses
            .length} greenhouses");

    _greenhouses.clear();
    _greenhouses.addAll(fetchedGreenhouses);
    // Update the cache
    _cacheService.update(_greenhousesCacheKey, jsonEncode(_greenhouses));

    return _greenhouses;
  }
}
