import 'package:herbarium_mobile/src/core/models/actuator_state.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';

class Plant {
  final String uuid;

  final int position;

  final DateTime plantedAt;

  final PlantType type;

  final double? overrideMoistureGoal;

  final double? overrideLightExposureMinDuration;

  final double? moistureLastReading;

  final double? lightLastReading;

  final ActuatorState? valveStatus;

  final ActuatorState? ligthStripStatus;

  final bool removed;

  Plant(
      {required this.uuid,
      required this.position,
      required this.plantedAt,
      required this.type,
      this.overrideMoistureGoal,
      this.overrideLightExposureMinDuration,
      this.moistureLastReading,
      this.lightLastReading,
      this.valveStatus,
      this.ligthStripStatus,
      this.removed = false});

  /// Determine the plant current stade.
  PlantStade get plantStade {
    final days = (DateTime.now()).difference(plantedAt).inDays;

    if(days < type.germinationTime) {
      return PlantStade.germination;
    }
    if(days < type.growingTime) {
      return PlantStade.growing;
    }
    return PlantStade.harvestable;
  }

  factory Plant.fromJson(Map<String, dynamic> map) => Plant(
      uuid: map["uuid"] as String,
      position: map["position"] as int,
      plantedAt: DateTime.parse(map['planted_at'] as String),
      type: PlantType.fromJson(map["type"] as Map<String, dynamic>),
      overrideMoistureGoal: map["override_moisture_goal"] as double?,
      overrideLightExposureMinDuration:
          map["light_exposure_min_duration"] as double?,
      moistureLastReading: map["moisture_last_reading"] != null
          ? double.parse(
              (map["moisture_last_reading"] as double).toStringAsFixed(2))
          : null,
      lightLastReading: map["light_last_reading"] != null
          ? double.parse(
              (map["light_last_reading"] as double).toStringAsFixed(2))
          : null,
      valveStatus: map["valve_status"] != null
          ? ActuatorState.fromJson(map["valve_status"] as Map<String, dynamic>)
          : null,
      ligthStripStatus: map["light_strip_status"] != null
          ? ActuatorState.fromJson(
              map["light_strip_status"] as Map<String, dynamic>)
          : null,
      removed: map["removed"] ?? false);
}

enum PlantStade {
  germination,
  growing,
  harvestable
}
