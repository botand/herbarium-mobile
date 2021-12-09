import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantType {
  /// Unique identifier of the plant type
  final int id;

  /// Name of the plant type e.g. tomato
  final String name;

  /// Percentage of moisture
  final double moistureGoal;

  /// Minimum exposure in hour for this type of plant
  final double lightExposureMinDuration;

  /// How many days (maximum) the plant is in the germination stade
  final int germinationTime;

  /// How many days (maximum) the plant is in the growing stade
  final int growingTime;

  PlantType(
      {required this.id,
      required this.name,
      required this.moistureGoal,
      required this.lightExposureMinDuration,
      required this.germinationTime,
      required this.growingTime});

  factory PlantType.fromJson(Map<String, dynamic> map) => PlantType(
      id: map["id"] as int,
      name: map["name"] as String,
      moistureGoal: map["moisture_goal"] as double,
      lightExposureMinDuration: map["light_exposure_min_duration"] as double,
      germinationTime: map["germination_time"] as int,
      growingTime: map["germination_time"] as int);

  @override
  String toString() {
    return 'PlantType{id: $id, '
        'name: $name, '
        'moistureGoal: $moistureGoal, '
        'lightExposureMinDuration: $lightExposureMinDuration, '
        'germinationTime: $germinationTime, '
        'growingTime: $growingTime}';
  }
}

extension PlantTypeNameToLocalized on PlantType {
  String toLocalized(AppLocalizations intl) {
    String localizedString;

    switch (name) {
      case "chive":
        localizedString = intl.plant_type_chive;
        break;
      case "coriander":
        localizedString = intl.plant_type_coriander;
        break;
      case "parsley":
        localizedString = intl.plant_type_parsley;
        break;
      case "thyme":
        localizedString = intl.plant_type_thyme;
        break;
      case "lettuce":
        localizedString = intl.plant_type_lettuce;
        break;
      case "cherry_tomatoes":
        localizedString = intl.plant_type_cherry_tomatoes;
        break;
      default:
        localizedString = intl.plant_type_default;
        break;
    }

    return localizedString;
  }
}