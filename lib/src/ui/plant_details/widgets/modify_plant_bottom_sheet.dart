import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/utils/utils.dart';
import 'package:herbarium_mobile/src/ui/base/base_bottom_sheet.dart';
import 'package:herbarium_mobile/src/ui/base/plant_type_carousel.dart';

class ModifyPlantBottomSheet extends StatefulWidget {
  final Plant plant;

  const ModifyPlantBottomSheet({Key? key, required this.plant})
      : super(key: key);

  @override
  State<ModifyPlantBottomSheet> createState() => _ModifyPlantBottomSheetState();
}

class _ModifyPlantBottomSheetState extends State<ModifyPlantBottomSheet> {
  late double _moistureValue;

  late double _exposureDuration;

  @override
  void initState() {
    super.initState();
    _moistureValue = widget.plant.moistureGoal;
    _exposureDuration = widget.plant.lightExposureMinDuration;
  }

  @override
  Widget build(BuildContext context) => BaseBottomSheet(
      title: Text(AppLocalizations.of(context)!.plant_modify_title,
          style: Theme.of(context).textTheme.headline5),
      child: ListView(
        children: _buildList(context),
      ));

  List<Widget> _buildList(BuildContext context) {
    final List<Widget> list = [];

    list.addAll(_buildMoistureSection(context));
    list.addAll(_buildExposureDuration(context));
    list.addAll(_buildType(context));

    return list;
  }

  List<Widget> _buildMoistureSection(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15.0, bottom: 2.0),
          child: Text(
            AppLocalizations.of(context)!.plant_modify_moisture_goal,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slider(
              value: _moistureValue,
              onChanged: (double value) {
                setState(() {
                  _moistureValue = value;
                });
              },
              label: AppLocalizations.of(context)!
                  .percentage(_moistureValue.round()),
              max: 80.0,
              min: 20.0,
              divisions: 12,
            ))
      ];

  List<Widget> _buildExposureDuration(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15.0, bottom: 2.0),
          child: Text(
            AppLocalizations.of(context)!.plant_modify_exposure_duration,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slider(
              value: _exposureDuration,
              onChanged: (double value) {
                setState(() {
                  _exposureDuration = value;
                });
              },
              label:
                  AppLocalizations.of(context)!.hour(_exposureDuration.round()),
              max: 24.0,
              min: 1.0,
              divisions: 24,
            ))
      ];

  List<Widget> _buildType(BuildContext context) => [
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.plant_modify_type,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => const AlertDialog(
                content: PlantTypesCarousel(),
              ));
            },
            style: ElevatedButton.styleFrom(primary: const Color(0xff88bd5e)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.plant.type
                      .toLocalized(AppLocalizations.of(context)!)
                      .toUpperCase(),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                    child: Image.asset(plantTagAsset(widget.plant.type.name)))
              ],
            ),
          ),
        )
      ];
}
