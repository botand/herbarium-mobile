import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';

class SetupPlantArguments {
  final Plant plant;

  final Greenhouse greenhouse;

  SetupPlantArguments({required this.plant, required this.greenhouse});
}
