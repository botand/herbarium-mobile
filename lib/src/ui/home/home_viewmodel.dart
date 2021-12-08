import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/repositories/greenhouse_repository.dart';
import 'package:herbarium_mobile/src/core/utils/http_exception.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  /// Allow the view model to interact with the greenhouses
  final GreenhousesRepository _greenhousesRepository =
      locator<GreenhousesRepository>();

  final Logger _logger = locator<Logger>();

  /// Used to create and recreate the [_tabController].
  final TickerProvider vsync;

  final AppLocalizations intl;

  /// Controls the [TabPageSelector] of the view.
  late TabController _tabController;

  TabController get tabController => _tabController;

  /// Indicate with greenhouse is currently display.
  int _currentGreenhouseIndex = 0;

  /// Return the greenhouse currently displayed.
  Greenhouse? get currentGreenhouse {
    if(_greenhousesRepository.greenhouses.isEmpty || _currentGreenhouseIndex >= _greenhousesRepository.greenhouses.length) {
      return null;
    }
    return _greenhousesRepository.greenhouses[_currentGreenhouseIndex];
  }

  /// Get the number of greenhouses owned by the user
  int get greenhousesNumber => _greenhousesRepository.greenhouses.length;

  HomeViewModel({required this.intl, required this.vsync}) {
    _tabController = TabController(length: 0, vsync: vsync);
  }

  @override
  Future futureToRun() async {
    await _greenhousesRepository.getGreenhouses();
    _checkTabController();
  }

  @override
  void onError(error) {
    setError(error);
    Fluttertoast.showToast(msg: intl.basic_error);
  }

  Future refresh() async {
    _logger.d("$runtimeType - Start refresh");
    setBusy(true);
    clearErrors();
    try {
      await _greenhousesRepository.getGreenhouses();
      _checkTabController();
    } on HttpException catch (e) {
      _logger.e("$runtimeType - Refresh failed");
      onError(e);
    }
    _logger.d("${runtimeType} - Refresh ended");
    setBusy(false);
  }

  void _checkTabController() {
    if (_tabController.length != greenhousesNumber) {
      _tabController.dispose();
      _tabController = TabController(
          length: greenhousesNumber,
          vsync: vsync,
          initialIndex: _currentGreenhouseIndex);
    }
  }

  /// Change the greenhouse currently displayed.
  void setGreenhouse(int index) {
    _currentGreenhouseIndex = index;
    _tabController.index = index;
    notifyListeners();
  }

  /// Retrieve a specific [Greenhouse], [index] being
  Greenhouse getGreenhouse(int index) {
    _currentGreenhouseIndex = index;
    return _greenhousesRepository.greenhouses[index];
  }

  void onDispose() {
    _tabController.dispose();
  }
}
