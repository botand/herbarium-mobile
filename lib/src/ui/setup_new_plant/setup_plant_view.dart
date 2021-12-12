import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/setup_plant_viewmodel.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/widgets/done_step.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/widgets/moved_plant_step.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/widgets/new_plant_step.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/widgets/setup_plant_first_step.dart';
import 'package:stacked/stacked.dart';

class SetupPlantView extends StatelessWidget {
  final Plant plant;

  final Greenhouse greenhouse;

  const SetupPlantView(
      {Key? key, required this.plant, required this.greenhouse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SetupPlantViewModel(
          plant: plant,
          greenhouse: greenhouse,
          intl: AppLocalizations.of(context)!),
      onModelReady: (SetupPlantViewModel viewModel) =>
          viewModel.loadPlantTypes(),
      builder: (BuildContext context, SetupPlantViewModel viewModel, _) =>
          BaseScaffold(
              showBottomBar: false,
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop()),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildStep(viewModel),
              )),
    );
  }

  Widget _buildStep(SetupPlantViewModel viewModel) {
    switch (viewModel.currentStep) {
      case SetupPlantStep.firstStep:
        return SetupPlantFirstStep(
            onTapNewPlant: viewModel.isNewPlant,
            onTapMovedPlant: viewModel.isMovedPlant);
      case SetupPlantStep.newPlant:
        return NewPlantStep(
          elements: viewModel.plantTypes,
          onSelectedItemChanged: (plantType) =>
              viewModel.selectedPlantType = plantType,
          onTapNext: viewModel.isNextEnabled ? viewModel.next : null,
        );
      case SetupPlantStep.movedPlant:
        return MovedPlantStep(
            onTap: (plant) => viewModel.selectedPlant = plant,
            greenhouse: viewModel.greenhouse);
      case SetupPlantStep.done:
      default:
        return DoneStep(onTapDone: viewModel.next);
    }
  }
}
