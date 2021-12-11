import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/repositories/greenhouses_repository.dart';
import 'package:herbarium_mobile/src/core/repositories/plant_types_repository.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SetupPlantViewModel extends BaseViewModel {
  final Logger _logger = locator<Logger>();

  final PlantTypesRepository _plantTypesRepository =
      locator<PlantTypesRepository>();

  final GreenhousesRepository _greenhousesRepository =
      locator<GreenhousesRepository>();

  final NavigationService _navigationService = locator<NavigationService>();

  final AppLocalizations intl;

  Plant _plant;

  Plant get plant => _plant;

  final Greenhouse greenhouse;

  SetupPlantStep _currentStep = SetupPlantStep.firstStep;

  SetupPlantStep get currentStep => _currentStep;

  List<PlantType> _plantTypes = [];

  List<PlantType> get plantTypes => _plantTypes;

  PlantType? _selectedPlantType;

  set selectedPlantType(PlantType type) {
    _selectedPlantType = type;
    notifyListeners();
  }

  SetupPlantViewModel(
      {required Plant plant, required this.greenhouse, required this.intl})
      : _plant = plant;

  void isNewPlant() => _toStep(SetupPlantStep.newPlant);

  void isMovedPlant() => _toStep(SetupPlantStep.movedPlant);

  bool get isNextEnabled {
    if (_currentStep == SetupPlantStep.newPlant) {
      return _selectedPlantType != null;
    }
    return false;
  }

  Future next() async {
    bool isSuccessful = true;
    if (_currentStep == SetupPlantStep.done) {
      _navigationService.pushNamedAndRemoveUntil(
          path: NavigationRoute.plantDetails,
          arguments: _plant,
          removeUntilRouteNamed: NavigationRoute.home);
      return;
    }

    if (_currentStep == SetupPlantStep.newPlant) {
      _plant = plant.copyWith(type: _selectedPlantType!);
      isSuccessful = await _greenhousesRepository.updatePlant(_plant);
    }

    if (isSuccessful) {
      _toStep(SetupPlantStep.done);
      return;
    }
    Fluttertoast.showToast(msg: intl.basic_error);
  }

  void _toStep(SetupPlantStep step) {
    _logger.d("$runtimeType - moving to step: $step");
    _currentStep = step;
    notifyListeners();
  }

  Future loadPlantTypes() async {
    _plantTypes = await _plantTypesRepository.getPlantTypes();
  }
}

enum SetupPlantStep { firstStep, newPlant, movedPlant, done }
