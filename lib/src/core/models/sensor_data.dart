class SensorData {
  /// Which type of sensor the reading is from
  final SensorType type;

  /// When the reading occurred
  final DateTime timestamp;

  /// Value read by the sensor
  final double value;

  /// On which plant the data was read if applicable
  final String? plantUuid;

  SensorData(
      {required this.type,
      required this.timestamp,
      required this.value,
      this.plantUuid});

  factory SensorData.fromJson(Map<String, dynamic> map) => SensorData(
      type: SensorType.values.firstWhere((element) =>
          element.toString().split(".")[1].toUpperCase() ==
          (map["type"] as String)),
      timestamp: DateTime.parse(map['timestamp'] as String),
      value: double.parse((map["value"] as double).toStringAsFixed(2)),
      plantUuid: map["plant_uuid"]);
}

enum SensorType {
  m, // Moisture sensor
  l, // Light sensor
  t // Tank level sensor
}
