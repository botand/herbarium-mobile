import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/plant_type.dart';
import 'package:herbarium_mobile/src/ui/base/plant_type_carousel.dart';

class NewPlantStep extends StatelessWidget {
  final VoidCallback? onTapNext;

  final List<PlantType> elements;

  final Function(PlantType)? onSelectedItemChanged;

  const NewPlantStep(
      {Key? key,
      required this.onTapNext,
      required this.elements,
      required this.onSelectedItemChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.plant_setup_new_growing,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        PlantTypesCarousel(
          elements: elements,
          onSelectedItemChanged: onSelectedItemChanged,
          height: 200,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: onTapNext,
                child: Text(AppLocalizations.of(context)!.next.toUpperCase()))
          ],
        )
      ],
    );
  }
}
