
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/services/api_service.dart';
import 'package:logger/logger.dart';

class GreenhousesRepository {
  final ApiService _apiService = locator<ApiService>();

  final Logger _logger = locator<Logger>();

  final List<Greenhouse> _greenhouses = [];
  List<Greenhouse> get greenhouses => _greenhouses;

  Future<List<Greenhouse>> getGreenhouses({fromCacheOnly = true}) async {
    // TODO retrieve from cache

    final fetchedGreenhouses = await _apiService.getGreenhouses();
    _logger.i("$runtimeType - getGreenhouses fetched ${fetchedGreenhouses.length} greenhouses");

    _greenhouses.clear();
    _greenhouses.addAll(fetchedGreenhouses);

    // TODO Update cache

    return _greenhouses;
  }

}