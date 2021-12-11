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

  final bool? valveStatus;

  final bool? lightStripStatus;

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
          map["override_light_exposure_min_duration"] as double?,
      moistureLastReading: map["moisture_last_reading"] != null
          ? double.parse(
              (map["moisture_last_reading"] as double).toStringAsFixed(2))
          : null,
      lightLastReading: map["light_last_reading"] != null
          ? double.parse(
              (map["light_last_reading"] as double).toStringAsFixed(2))
          : null,
      valveStatus: map["valve_status"] != null
          ? map["valve_status"] as bool
          : null,
      lightStripStatus: map["light_strip_status"] != null
          ? map["light_strip_status"] as bool
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

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'position': position,
        'planted_at': plantedOn.toIso8601String(),
        'type': type,
        'override_moisture_goal': overrideMoistureGoal,
        'light_exposure_min_duration': overrideLightExposureMinDuration,
        'moisture_last_reading': moistureLastReading,
        'light_last_reading': lightLastReading,
        'valve_status': valveStatus,
        'light_strip_status': lightStripStatus,
        'removed': removed
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Plant &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          position == other.position &&
          plantedOn == other.plantedOn &&
          type == other.type &&
          overrideMoistureGoal == other.overrideMoistureGoal &&
          overrideLightExposureMinDuration ==
              other.overrideLightExposureMinDuration &&
          moistureLastReading == other.moistureLastReading &&
          lightLastReading == other.lightLastReading &&
          valveStatus == other.valveStatus &&
          lightStripStatus == other.lightStripStatus &&
          removed == other.removed;

  @override
  int get hashCode =>
      uuid.hashCode ^
      position.hashCode ^
      plantedOn.hashCode ^
      type.hashCode ^
      overrideMoistureGoal.hashCode ^
      overrideLightExposureMinDuration.hashCode ^
      moistureLastReading.hashCode ^
      lightLastReading.hashCode ^
      valveStatus.hashCode ^
      lightStripStatus.hashCode ^
      removed.hashCode;
}

extension CopyPlant on Plant {
  Plant copyWith(
          {int? position,
          DateTime? plantedOn,
          PlantType? type,
          double? overrideMoistureGoal,
          double? overrideLightExposureMinDuration}) =>
      Plant(
          uuid: uuid,
          position: position ?? this.position,
          type: type ?? this.type,
          plantedOn: plantedOn ?? this.plantedOn,
          overrideMoistureGoal:
              overrideMoistureGoal ?? this.overrideMoistureGoal,
          overrideLightExposureMinDuration: overrideLightExposureMinDuration ??
              this.overrideLightExposureMinDuration,
          moistureLastReading: moistureLastReading,
          lightLastReading: lightLastReading,
          valveStatus: valveStatus,
          lightStripStatus: lightStripStatus,
          removed: removed);
}

enum PlantStage { germination, growing, harvestable }
