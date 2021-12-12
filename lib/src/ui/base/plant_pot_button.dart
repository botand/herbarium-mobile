import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/utils/utils.dart';

class PlantPotButton extends StatefulWidget {
  final VoidCallback? onTap;

  final Plant? plant;

  final bool showLabel;

  const PlantPotButton(
      {Key? key, this.onTap, this.plant, this.showLabel = true})
      : super(key: key);

  @override
  State<PlantPotButton> createState() => _PlantPotButtonState();
}

class _PlantPotButtonState extends State<PlantPotButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isOn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        if (_controller.isCompleted) {
          setState(() {
            _isOn = !_isOn;
          });
          _controller.forward(from: 0.0);
        }
      })
      ..forward();
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: widget.onTap,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.plant != null
                ? _buildPlant(context)
                : _buildFrenchClip()),
      );

  List<Widget> _buildPlant(BuildContext context) {
    String plantPotImageAsset = "assets/images/plant_pot_with_light_off.png";

    if (widget.plant!.type.id == 1) {
      return _buildBlinkingPlant(context);
    }

    if (widget.plant!.lightStripStatus != null &&
        widget.plant!.lightStripStatus!) {
      plantPotImageAsset = "assets/images/plant_pot_with_light_on.png";
    }
    return [
      Hero(
        tag: widget.plant!.uuid,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Image.asset(plantPotImageAsset, fit: BoxFit.fitHeight)),
            if (widget.plant!.type.id > 1)
              AspectRatio(
                  aspectRatio: 6 / 2,
                  child: Image.asset(plantTagAsset(widget.plant!.type.name))),
          ],
        ),
      ),
      if (widget.showLabel)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: AutoSizeText(
                widget.plant!.type.toLocalized(AppLocalizations.of(context)!)),
          ),
        )
    ];
  }

  List<Widget> _buildBlinkingPlant(BuildContext context) {
    String plantPotImageAsset = "assets/images/plant_pot_with_light_off.png";
    String plantPotImageAssetRed =
        "assets/images/plant_pot_with_light_red_on.png";

    return [
      Hero(
        tag: widget.plant!.uuid,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                    _isOn ? plantPotImageAsset : plantPotImageAssetRed,
                    fit: BoxFit.fitHeight)),
            if (widget.plant!.type.id > 1)
              AspectRatio(
                  aspectRatio: 6 / 2,
                  child: Image.asset(plantTagAsset(widget.plant!.type.name))),
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: AutoSizeText(
              AppLocalizations.of(context)!.greenhouse_new_plant,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.red)),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
