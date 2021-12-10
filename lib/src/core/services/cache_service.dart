import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as lib;
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/services/analytics_service.dart';
import 'package:herbarium_mobile/src/core/utils/cache_exception.dart';
import 'package:logger/logger.dart';

/// Abstraction of the cache management system.
class CacheService {
  /// Name of the cache.
  static const _key = 'HerbariumCache';

  final lib.CacheManager _cacheManager = lib.CacheManager(
    lib.Config(_key,
        stalePeriod: const Duration(days: 30),
        maxNrOfCacheObjects: 20,
        repo: lib.CacheObjectProvider(databaseName: _key)),
  );

  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  final Logger _logger = locator<Logger>();

  /// Get from the cache the value associated with [key].
  /// Throw a [CacheException] if the [key] doesn't exist.
  Future<String> get(String key) async {
    final lib.FileInfo? fileInfo = await _cacheManager.getFileFromCache(key);

    if (fileInfo == null) {
      _analyticsService.logEvent(runtimeType.toString(),
          "Trying to access $key from the cache but file doesn't exists");
      throw CacheException(
          prefix: runtimeType.toString(),
          message: "$key doesn't exist in the cache");
    }

    return fileInfo.file.readAsString();
  }

  /// Update/create in the cache the value associated with [key].
  Future update(String key, String value) async {
    try {
      await _cacheManager.putFile(
          key, UriData.fromString(value, encoding: utf8).contentAsBytes());
      _logger.d("$runtimeType - update $key successful");
    } on Exception catch (e, stacktrace) {
      _logger.e("$runtimeType - update $key failed");
      _analyticsService.logError(
          runtimeType.toString(),
          "Exception raised during cache update of $key: ${e.toString()}",
          e,
          stacktrace);
      rethrow;
    }
  }

  /// Delete from the cache the content associated with [key].
  Future delete(String key) async {
    try {
      await _cacheManager.removeFile(key);
      _logger.d("$runtimeType - delete $key successful");
    } on Exception catch (e, stacktrace) {
      _logger.e("$runtimeType - delete $key failed");
      _analyticsService.logError(
          runtimeType.toString(),
          "Exception raised during cache delete of $key: ${e.toString()}",
          e,
          stacktrace);
    }
  }

  /// Empty the cache
  Future empty() async {
    try {
      await _cacheManager.emptyCache();
      _logger.d("$runtimeType - clear cache successful");
    } on Exception catch (e, stacktrace) {
      _logger.e("$runtimeType - clear cache failed");
      _analyticsService.logError(runtimeType.toString(),
          "Exception raised during emptying cache: $e", e, stacktrace);
      rethrow;
    }
  }
}
