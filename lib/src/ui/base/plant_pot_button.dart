import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';

class PlantPotButton extends StatelessWidget {
  final VoidCallback? onTap;

  final Plant? plant;

  final bool showLabel;

  const PlantPotButton({Key? key, this.onTap, this.plant, this.showLabel = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Column(
        mainAxisSize: MainAxisSize.min,
        children: plant != null ? _buildPlant() : _buildFrenchClip()),
  );

  List<Widget> _buildPlant() {
    String imageAsset = "assets/images/plant_pot_with_light_off.png";

    if (plant!.ligthStripStatus != null && plant!.ligthStripStatus!.status) {
      imageAsset = "assets/images/plant_pot_with_light_on.png";
    }
    return [
      Image.asset(imageAsset),
      if (showLabel)
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Center(child: Text(plant!.type.name)),
        )
    ];
  }

  List<Widget> _buildFrenchClip() =>
      [Image.asset("assets/images/french_clip_light_off.png")];
}
