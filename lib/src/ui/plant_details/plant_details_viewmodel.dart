import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/repositories/greenhouses_repository.dart';
import 'package:herbarium_mobile/src/core/repositories/plant_types_repository.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class PlantDetailsViewModel extends BaseViewModel {
  final PlantTypesRepository _plantTypesRepository =
      locator<PlantTypesRepository>();

  final GreenhousesRepository _greenhousesRepository =
  locator<GreenhousesRepository>();

  final NavigationService _navigationService = locator<NavigationService>();

  final AppLocalizations intl;

  Plant _plant;
  Plant get plant => _plant;

  List<PlantType> _plantTypes = [];

  List<PlantType> get plantTypes => _plantTypes;

  PlantDetailsViewModel(this._plant, this.intl);

  Future loadPlantTypes() async {
    _plantTypes = await _plantTypesRepository.getPlantTypes();
  }

  Future updatePlantDetails(
      double moistureGoal, double exposureDuration, PlantType plantType) async {
    Plant newPlant = plant;
    if (plant.type != plantType) {
      newPlant = newPlant.copyWith(type: plantType);
    }

    moistureGoal = moistureGoal.roundToDouble();
    if (moistureGoal != newPlant.moistureGoal) {
      newPlant = newPlant.copyWith(overrideMoistureGoal: moistureGoal);
    }

    exposureDuration = exposureDuration.roundToDouble();
    if (exposureDuration != newPlant.lightExposureMinDuration) {
      newPlant =
          newPlant.copyWith(overrideLightExposureMinDuration: exposureDuration);
    }

    if(newPlant != plant) {
      setBusy(true);
      if(!(await _greenhousesRepository.updatePlant(newPlant))) {
        Fluttertoast.showToast(msg: intl.basic_error);
      } else {
        _plant = newPlant;
        _navigationService.pop();
      }
      setBusy(false);
    }
  }
}
