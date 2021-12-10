import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/utils/custom_icons.dart';
import 'package:herbarium_mobile/src/ui/base/plant_pot_button.dart';
import 'package:herbarium_mobile/src/ui/base/ring_led_animated.dart';

class GreenhouseDetails extends StatelessWidget {
  final Greenhouse greenhouse;

  final Function(Plant) onTap;

  const GreenhouseDetails({Key? key, required this.greenhouse, required this.onTap})
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
                  Plant? plant = greenhouse.getPlant(index);
                  return PlantPotButton(
                      plant: plant,
                      onTap: plant != null
                          ? () => onTap(plant)
                          : null);
                }),
          ),
          _buildGreenhouseStatusBar(context),
        ],
      );

  Widget _buildGreenhouseStatusBar(BuildContext context) {
    Color tankIconColor;
    String tankString = AppLocalizations.of(context)!.na;

    switch (greenhouse.tankStatus) {
      case TankStatus.normal:
        tankIconColor = Colors.blue;
        break;
      case TankStatus.nearlyEmpty:
        tankIconColor = Colors.deepOrangeAccent;
        break;
      case TankStatus.empty:
        tankIconColor = Colors.red;
        break;
      case TankStatus.unknown:
        tankIconColor = Colors.blueGrey;
        break;
    }

    if (greenhouse.tankStatus != TankStatus.unknown) {
      tankString = AppLocalizations.of(context)!
          .percentage(greenhouse.tankLevel!.value.round());
    }

    return Padding(
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
                Icon(CustomIcons.water_drop_outline,
                    color: tankIconColor, size: 32),
                Text(tankString),
              ],
            ),
          ),
          SizedBox(
              height: 60,
              width: 60,
              child: RingLedAnimated(pattern: getPattern())),
          Expanded(
              child: Center(
                  child: Text(getStatus(AppLocalizations.of(context)!)))),
        ],
      ),
    );
  }

  RingPattern getPattern() {
    if ((DateTime.now()).difference(greenhouse.lastTimestamp).inMinutes > 15) {
      return RingPattern.breathingRed;
    }
    if (greenhouse.tankStatus == TankStatus.nearlyEmpty) {
      return RingPattern.breathingBlue;
    }
    if (greenhouse.tankStatus == TankStatus.empty) {
      return RingPattern.blinkingBlue;
    }
    return RingPattern.solidLeafGreen;
  }

  String getStatus(AppLocalizations intl) {
    if ((DateTime.now()).difference(greenhouse.lastTimestamp).inMinutes > 15) {
      return intl.greenhouse_status_connection_lost;
    }
    if (greenhouse.tankStatus == TankStatus.empty) {
      return intl.greenhouse_status_tank_empty;
    }
    return "";
  }
}
