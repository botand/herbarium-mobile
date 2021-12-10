import 'package:herbarium_mobile/src/core/models/actuator_state.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';

class Plant {
  final String uuid;

  final int position;

  final DateTime plantedOn;

  final PlantType type;

  final double? overrideMoistureGoal;

  final double? overrideLightExposureMinDuration;

  final double? moistureLastReading;

  final double? lightLastReading;

  final ActuatorState? valveStatus;

  final ActuatorState? lightStripStatus;

  final bool removed;

  Plant(
      {required this.uuid,
      required this.position,
      required this.plantedOn,
      required this.type,
      this.overrideMoistureGoal,
      this.overrideLightExposureMinDuration,
      this.moistureLastReading,
      this.lightLastReading,
      this.valveStatus,
      this.lightStripStatus,
      this.removed = false});

  /// Determine the plant current stage.
  PlantStage get plantStage {
    final days = (DateTime.now()).difference(plantedOn).inDays;

    if (days < type.germinationTime) {
      return PlantStage.germination;
    }
    if (days < type.growingTime) {
      return PlantStage.growing;
    }
    return PlantStage.harvestable;
  }

  double get moistureGoal => overrideMoistureGoal ?? type.moistureGoal;

  double get lightExposureMinDuration =>
      overrideLightExposureMinDuration ?? type.lightExposureMinDuration;

  factory Plant.fromJson(Map<String, dynamic> map) => Plant(
      uuid: map["uuid"] as String,
      position: map["position"] as int,
      plantedOn: DateTime.parse(map['planted_at'] as String),
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
      lightStripStatus: map["light_strip_status"] != null
          ? ActuatorState.fromJson(
              map["light_strip_status"] as Map<String, dynamic>)
          : null,
      removed: map["removed"] ?? false);

  @override
  String toString() {
    return 'Plant{uuid: $uuid, '
        'position: $position, '
        'plantedAt: $plantedOn, '
        'type: $type, '
        'overrideMoistureGoal: $overrideMoistureGoal, '
        'overrideLightExposureMinDuration: $overrideLightExposureMinDuration, '
        'moistureLastReading: $moistureLastReading, '
        'lightLastReading: $lightLastReading, '
        'valveStatus: $valveStatus, '
        'lightStripStatus: $lightStripStatus, '
        'removed: $removed}';
  }
}

enum PlantStage { germination, growing, harvestable }
