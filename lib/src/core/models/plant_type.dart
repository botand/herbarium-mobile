class PlantType {
  /// Unique identifier of the plant type
  final int id;

  /// Name of the plant type e.g. tomato
  final String name;

  /// Percentage of moisture
  final double moistureGoal;

  /// Minimum exposure in hour for this type of plant
  final double lightExposureMinDuration;

  PlantType(
      {required this.id,
      required this.name,
      required this.moistureGoal,
      required this.lightExposureMinDuration});

  factory PlantType.fromJson(Map<String, dynamic> map) => PlantType(
      id: map["id"] as int,
      name: map["name"] as String,
      moistureGoal: map["moisture_goal"] as double,
      lightExposureMinDuration: map["light_exposure_min_duration"] as double);
}
