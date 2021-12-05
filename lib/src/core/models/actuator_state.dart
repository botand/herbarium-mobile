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
          element.toString().toUpperCase() == (map["type"] as String)),
      timestamp: DateTime.parse(map['timestamp'] as String),
      status: map["value"] as bool,
      plantUuid: map["plant_uuid"]);
}

enum ActuatorType {
  v, // Valve
  l, // Light strip
  p // Pump
}
