import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/sensor_data.dart';

class Greenhouse {
  final String uuid;

  final String name;

  final List<Plant> plants;

  final SensorData? tankLevel;

  final DateTime lastTimestamp;

  final DateTime createdAt;

  Greenhouse(
      {required this.uuid,
      required this.name,
      this.plants = const [],
      this.tankLevel,
      required this.lastTimestamp,
      required this.createdAt});

  /// Get a plant based on its position in the greenhouse
  Plant? getPlant(int position) {
    for (Plant plant in plants) {
      if (plant.position == position) {
        return plant;
      }
    }
    return null;
  }

  factory Greenhouse.fromJson(Map<String, dynamic> map) => Greenhouse(
      uuid: map["uuid"] as String,
      name: map["name"] as String,
      plants: map["plants"] != null
          ? (map["plants"] as List<dynamic>)
              .map((e) => Plant.fromJson(e))
              .toList()
          : [],
      tankLevel: map["tank_level"] != null
          ? SensorData.fromJson(map["tank_level"] as Map<String, dynamic>)
          : null,
      lastTimestamp: DateTime.parse(map['created_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String));
}
