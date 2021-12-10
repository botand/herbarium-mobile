import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/core/utils/utils.dart';

class PlantTypesCarousel extends StatefulWidget {
  final PlantType? type;

  final double height;

  final List<PlantType> elements;

  final Function(PlantType)? onSelectedItemChanged;

  const PlantTypesCarousel(
      {Key? key,
      this.type,
      required this.height,
      this.onSelectedItemChanged,
      required this.elements})
      : super(key: key);

  @override
  State<PlantTypesCarousel> createState() => _PlantTypesCarouselState();
}

class _PlantTypesCarouselState extends State<PlantTypesCarousel> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    int initialPosition = 0;
    if (widget.type != null) {
      initialPosition = widget.elements
          .indexWhere((element) => widget.type!.id == element.id);
    }

    _controller = FixedExtentScrollController(
        initialItem: (initialPosition < 0) ? 0 : initialPosition);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: (widget.height + 50),
        child: RotatedBox(
          quarterTurns: 3,
          child: ListWheelScrollView(
              controller: _controller,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: widget.onSelectedItemChanged == null
                  ? null
                  : (index) =>
                      widget.onSelectedItemChanged!(widget.elements[index]),
              itemExtent: widget.height,
              children: _buildCards(context)),
        ),
      );

  List<Widget> _buildCards(BuildContext context) {
    final List<Widget> types = [];

    for (final PlantType type in widget.elements) {
      types.add(RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
                aspectRatio: 1,
                child:
                    Image.asset(plantTagAsset(type.name), fit: BoxFit.contain)),
            Text(type.toLocalized(AppLocalizations.of(context)!))
          ],
        ),
      ));
    }

    return types;
  }
}
