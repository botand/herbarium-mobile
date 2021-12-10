class ActuatorState {
  /// Which type of sensor the reading is from
  final ActuatorType type;

  /// When the reading occurred
  final DateTime timestamp;

  /// Value read by the sensor
  final bool status;

  /// On which plant the data was read if applicable
  final String? plantUuid;

  ActuatorState(
      {required this.type,
      required this.timestamp,
      required this.status,
      this.plantUuid});

  factory ActuatorState.fromJson(Map<String, dynamic> map) => ActuatorState(
      type: ActuatorType.values.firstWhere((element) =>
          element.toString().split(".")[1].toUpperCase() ==
          (map["type"] as String).toUpperCase()),
      timestamp: DateTime.parse(map['timestamp'] as String),
      status: map["value"] as bool,
      plantUuid: map["plant_uuid"]);

  @override
  String toString() {
    return 'ActuatorState{type: $type, timestamp: $timestamp, status: $status, plantUuid: $plantUuid}';
  }

  Map<String, dynamic> toJson() => {
        'type': type.toShortString(),
        'timestamp': timestamp.toIso8601String(),
        'status': status,
        'plant_uuid': plantUuid
      };
}

enum ActuatorType {
  v, // Valve
  l, // Light strip
  p // Pump
}

extension ShortString on ActuatorType {
  String toShortString() => toString().split(".")[1];
}
