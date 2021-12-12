import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/setup_greenhouse_viewmodel.dart';
import 'package:herbarium_mobile/src/ui/base/done_step.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/widgets/register_greenhouse_step.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/widgets/search_greenhouse_step.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/widgets/setup_wifi_greenhouse_step.dart';
import 'package:stacked/stacked.dart';

class SetupGreenHouseView extends StatelessWidget {
  const SetupGreenHouseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<SetupGreenHouseViewModel>.nonReactive(
          viewModelBuilder: () =>
              SetupGreenHouseViewModel(intl: AppLocalizations.of(context)!),
          onDispose: (viewModel) => viewModel.stopScan(),
          onModelReady: (viewModel) => viewModel.startScan(),
          builder: (context, viewModel, child) => BaseScaffold(
              isLoading: viewModel.isBusy,
              isInteractionLimitedWhileLoading: true,
              showBottomBar: false,
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop()),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildStep(viewModel),
              )));

  Widget _buildStep(SetupGreenHouseViewModel viewModel) {
    switch (viewModel.currentStep) {
      case SetupGreenhouseStep.search:
        return const SearchGreenhouseStep();
      case SetupGreenhouseStep.register:
        return RegisterGreenhouseStep(onTapNext: viewModel.registerGreenhouse);
      case SetupGreenhouseStep.setupWifi:
        return SetupWifiGreenhouseStep(onTapNext: viewModel.setupWifi);
      case SetupGreenhouseStep.done:
      default:
        return DoneStep(onTapDone: viewModel.next);
    }
  }
}
