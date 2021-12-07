import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/utils/custom_icons.dart';
import 'package:herbarium_mobile/src/ui/base/plant_pot_button.dart';

class GreenhouseDetails extends StatelessWidget {
  final Greenhouse greenhouse;

  const GreenhouseDetails({Key? key, required this.greenhouse})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Flexible(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.47)),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 16,
            shrinkWrap: true,
            // reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return PlantPotButton(plant: greenhouse.getPlant(index));
            }),
      ),
      _buildGreenhouseStatusBar(context),
    ],
  );

  Widget _buildGreenhouseStatusBar(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CustomIcons.water_drop_outline,
                      color: Colors.blue, size: 32),
                  Text(greenhouse.tankLevel != null ? AppLocalizations.of(
                      context)!.percentage(greenhouse.tankLevel!.value):AppLocalizations.of(
                      context)!.na),
                ],
              ),
            ),
            Container(
              color: Colors.orange,
              height: 50,
              width: 50,
            ),
            Expanded(child: Center(child: Text("Status here"))),
          ],
        ),
      );
}
