import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';

class PlantLifeCycleIndicator extends StatelessWidget {
  final double? width;

  final double? height;

  final Plant plant;

  const PlantLifeCycleIndicator(
      {Key? key, required this.plant, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double finalWidth = width ?? MediaQuery.of(context).size.width;
    double finalHeight = height ?? MediaQuery.of(context).size.height;
    final totalDays = plant.type.growingTime + plant.type.germinationTime;
    final elapsedDays = (DateTime.now()).difference(plant.plantedAt).inDays;
    final completion = elapsedDays / totalDays;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: finalWidth,
        height: finalHeight,
        child: Stack(
          children: [
            SizedBox(
              width: finalWidth,
              height: finalHeight,
              child: CircularProgressIndicator(
                value: completion,
                strokeWidth: 15,
                backgroundColor: AppTheme.purpleLight,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppTheme.leafGreen),
              ),
            ),
            Center(
              child: Text(_determineState(AppLocalizations.of(context)!),
                  style: Theme.of(context).textTheme.headline6),
            )
          ],
        ),
      ),
    );
  }

  String _determineState(AppLocalizations intl) {
    String stadeString;
    switch(plant.plantStade) {
      case PlantStade.germination:
        stadeString = intl.plant_stade_germination;
        break;
      case PlantStade.growing:
        stadeString = intl.plant_stade_growing;
        break;
      case PlantStade.harvestable:
        stadeString = intl.plant_stade_harvestable;
        break;
    }

    return stadeString;
  }
}
