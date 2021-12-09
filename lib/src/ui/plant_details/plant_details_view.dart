import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';
import 'package:herbarium_mobile/src/core/utils/custom_icons.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:herbarium_mobile/src/ui/base/plant_pot_button.dart';
import 'package:herbarium_mobile/src/ui/plant_details/widgets/plant_lifecycle_indicator.dart';

class PlantDetailsView extends StatelessWidget {
  final Plant plant;

  const PlantDetailsView({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseScaffold(
      showBottomBar: false,
      appBar: AppBar(
        title: Text(plant.type.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlantPotButton(plant: plant, showLabel: false),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(CustomIcons.water_drop_outline,
                                  size: 32),
                            ),
                            const SizedBox(width: 12),
                            Text(
                                plant.moistureLastReading != null
                                    ? AppLocalizations.of(context)!.percentage(
                                        plant.moistureLastReading!.round())
                                    : AppLocalizations.of(context)!.na,
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.light_mode_outlined, size: 32),
                          ),
                          const SizedBox(width: 12),
                          Text(
                              plant.lightLastReading != null
                                  ? AppLocalizations.of(context)!.percentage(
                                      plant.lightLastReading!.round())
                                  : AppLocalizations.of(context)!.na,
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: PlantLifeCycleIndicator(plant: plant))
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [],
          ))
        ],
      ));
}
