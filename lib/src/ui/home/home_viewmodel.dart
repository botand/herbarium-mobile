import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/repositories/greenhouses_repository.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:herbarium_mobile/src/core/utils/http_exception.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/models/setup_plant_arguments.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  /// Allow the view model to interact with the greenhouses
  final GreenhousesRepository _greenhousesRepository =
      locator<GreenhousesRepository>();

  final NavigationService _navigationService = locator<NavigationService>();

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
    if (_greenhousesRepository.greenhouses.isEmpty ||
        _currentGreenhouseIndex >= _greenhousesRepository.greenhouses.length) {
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

  void startSetupWorkflow() {
    _navigationService.pushNamed(NavigationRoute.setup);
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
    _logger.d("$runtimeType - Refresh ended");
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

  /// Check if the current greenhouse can be updated and do so.
  /// Will close the bottom sheet if there is nothing to change or if the
  /// change succeed
  Future updateCurrentGreenhouse(String name) async {
    Greenhouse greenhouse =
        _greenhousesRepository.greenhouses[_currentGreenhouseIndex];
    if (greenhouse.name != name) {
      setBusy(true);
      if (!(await _greenhousesRepository
          .updateGreenhouse(greenhouse.copyWith(name: name)))) {
        Fluttertoast.showToast(msg: intl.basic_error);
      } else {
        _navigationService.pop();
      }
      setBusy(false);
    } else {
      _navigationService.pop();
    }
  }

  /// Delete the current greenhouse then reload the page.
  Future<void> deleteCurrentGreenhouse() async {
    setBusy(true);
    if (!(await _greenhousesRepository.deleteGreenhouse(currentGreenhouse!))) {
      Fluttertoast.showToast(msg: intl.basic_error);
      _currentGreenhouseIndex = 1;
      _tabController.index = 1;
      _checkTabController();
    } else {
      _navigationService.pop();
    }
    setBusy(false);
  }

  /// Move to [plant] details
  void onPlantTap(Plant plant) {
    if (plant.type.id == 1) {
      _navigationService.pushNamed(NavigationRoute.setupPlant,
          arguments: SetupPlantArguments(
              plant: plant, greenhouse: currentGreenhouse!));
    } else {
      _navigationService.pushNamed(NavigationRoute.plantDetails,
          arguments: plant);
    }
  }

  void onDispose() {
    _tabController.dispose();
  }
}
