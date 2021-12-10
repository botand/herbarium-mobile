import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/utils/utils.dart';

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'moisture_goal': moistureGoal,
        'light_exposure_min_duration': lightExposureMinDuration,
        'germination_time': germinationTime,
        'growing_time': growingTime
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          moistureGoal == other.moistureGoal &&
          lightExposureMinDuration == other.lightExposureMinDuration &&
          germinationTime == other.germinationTime &&
          growingTime == other.growingTime;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      moistureGoal.hashCode ^
      lightExposureMinDuration.hashCode ^
      germinationTime.hashCode ^
      growingTime.hashCode;
}

extension PlantTypeNameToLocalized on PlantType {
  String toLocalized(AppLocalizations intl) => plantTypeToLocalized(intl, name);
}
