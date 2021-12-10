import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/core/utils/utils.dart';

class PlantTypesCarousel extends StatelessWidget {
  const PlantTypesCarousel({Key? key}) : super(key: key);

  final List<String> _listPlantTypes = const [
    "chive",
    "coriander",
    "lettuce",
    "parsley",
    "thyme",
    "cherry_tomatoes"
  ];

  @override
  Widget build(BuildContext context) =>
      SizedBox(
        height: 200,
        child: ListWheelScrollView(
            itemExtent: 42, children: _buildCards(context)),
      );

  List<Widget> _buildCards(BuildContext context) {
    final List<Widget> types = [];

    for (final String typeName in _listPlantTypes) {
      types.add(Card(child: Image.asset(plantTagAsset(typeName))));
    }

    return types;
  }
}
