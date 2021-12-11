import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';

class SetupPlantFirstStep extends StatelessWidget {
  final VoidCallback onTapNewPlant;

  final VoidCallback onTapMovedPlant;

  const SetupPlantFirstStep(
      {Key? key, required this.onTapNewPlant, required this.onTapMovedPlant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height / 6;
    final cardTextStyle = Theme.of(context).textTheme.headline6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.plant_setup_new_plant_question,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTapNewPlant,
                child: Card(
                  color: AppTheme.leafGreen,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: cardHeight,
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset("assets/images/new_plant.png", fit: BoxFit.fill),
                        ),
                        Text(
                            AppLocalizations.of(context)!
                                .plant_setup_question_new_plant,
                            style: cardTextStyle),
                      ]),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: onTapMovedPlant,
                child: Card(
                  color: AppTheme.leafGreen,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: cardHeight,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset("assets/images/moving_plant.png", fit: BoxFit.fill),
                        ),
                        Text(
                            AppLocalizations.of(context)!
                                .plant_setup_question_moved_plant,
                            style: cardTextStyle),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
