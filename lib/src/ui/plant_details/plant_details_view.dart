import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/utils/custom_icons.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:herbarium_mobile/src/ui/base/plant_pot_button.dart';
import 'package:herbarium_mobile/src/ui/plant_details/widgets/modify_plant_bottom_sheet.dart';
import 'package:herbarium_mobile/src/ui/plant_details/widgets/plant_lifecycle_indicator.dart';

class PlantDetailsView extends StatelessWidget {
  final Plant plant;

  const PlantDetailsView({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseScaffold(
      showBottomBar: false,
      appBar: AppBar(
        title: Text(plant.type.toLocalized(AppLocalizations.of(context)!)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => showModalBottomSheet(
                enableDrag: true,
                context: context,
                builder: (context) => ModifyPlantBottomSheet(plant: plant)),
          )
        ],
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
          _buildPlantInfoSection(context)
        ],
      ));

  Widget _buildPlantInfoSection(BuildContext context) => Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.badge_outlined, size: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(AppLocalizations.of(context)!.plant_info,
                      style: Theme.of(context).textTheme.headline5),
                )
              ]),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  AppLocalizations.of(context)!
                      .plant_details_moisture_goal(plant.moistureGoal),
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  AppLocalizations.of(context)!.plant_details_exposure_duration(
                      plant.lightExposureMinDuration),
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  AppLocalizations.of(context)!.planted_on(plant.plantedOn),
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ));
}
