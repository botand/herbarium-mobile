import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/ui/home/widgets/greenhouse_details.dart';

class MovedPlantStep extends StatelessWidget {
  final Function(Plant) onTap;

  final Greenhouse greenhouse;

  const MovedPlantStep(
      {Key? key, required this.onTap, required this.greenhouse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.plant_setup_which_moved,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Expanded(
            child: GreenhouseDetails(
                greenhouse: greenhouse,
                onTap: onTap,
                showRemovedOnly: true,
                showDetails: false))
      ],
    );
  }
}
