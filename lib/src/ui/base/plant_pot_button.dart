import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';

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
            children: plant != null ? _buildPlant(context) : _buildFrenchClip()),
      );

  List<Widget> _buildPlant(BuildContext context) {
    String imageAsset = "assets/images/plant_pot_with_light_off.png";

    if (plant!.lightStripStatus != null && plant!.lightStripStatus!.status) {
      imageAsset = "assets/images/plant_pot_with_light_on.png";
    }
    return [
      Hero(
        tag: plant!.uuid,
        child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(imageAsset, fit: BoxFit.fitHeight)),
      ),
      if (showLabel)
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Center(child: Text(plant!.type.toLocalized(AppLocalizations.of(context)!))),
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
