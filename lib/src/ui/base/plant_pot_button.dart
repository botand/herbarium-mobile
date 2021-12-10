import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/utils/utils.dart';

class PlantPotButton extends StatelessWidget {
  final VoidCallback? onTap;

  final Plant? plant;

  final bool showLabel;

  const PlantPotButton(
      {Key? key, this.onTap, this.plant, this.showLabel = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                plant != null ? _buildPlant(context) : _buildFrenchClip()),
      );

  List<Widget> _buildPlant(BuildContext context) {
    String plantPotImageAsset = "assets/images/plant_pot_with_light_off.png";

    if (plant!.lightStripStatus != null && plant!.lightStripStatus!.status) {
      plantPotImageAsset = "assets/images/plant_pot_with_light_on.png";
    }
    return [
      Hero(
        tag: plant!.uuid,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Image.asset(plantPotImageAsset, fit: BoxFit.fitHeight)),
            if (plant!.type.id > 1)
              AspectRatio(
                  aspectRatio: 6 / 2,
                  child: Image.asset(plantTagAsset(plant!.type.name))),
          ],
        ),
      ),
      if (showLabel)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child:
                  AutoSizeText(plant!.type.toLocalized(AppLocalizations.of(context)!)),
          ),
        )
    ];
  }

  List<Widget> _buildFrenchClip() => [
        AspectRatio(
            aspectRatio: 1,
            child: Image.asset("assets/images/french_clip_light_off.png",
                fit: BoxFit.fitHeight))
      ];
}
