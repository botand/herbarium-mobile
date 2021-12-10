import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:herbarium_mobile/src/ui/home/home_viewmodel.dart';
import 'package:herbarium_mobile/src/ui/home/widgets/greenhouse_details.dart';
import 'package:herbarium_mobile/src/ui/home/widgets/modify_greenhouse_info_bottom_sheet.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () =>
            HomeViewModel(vsync: this, intl: AppLocalizations.of(context)!),
        onDispose: (HomeViewModel viewModel) => viewModel.onDispose,
        fireOnModelReadyOnce: true,
        builder: (context, viewModel, child) => BaseScaffold(
            isLoading: viewModel.isBusy,
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(viewModel.currentGreenhouse?.name ?? ""),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => showModalBottomSheet(
                          enableDrag: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => ModifyGreenhouseInfoBottomSheet(
                                greenhouse: viewModel.currentGreenhouse!,
                                onSave: viewModel.updateCurrentGreenhouse,
                                onDelete: viewModel.deleteCurrentGreenhouse,
                              )),
                    ),
                  )
                ],
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                if (viewModel.currentGreenhouse != null)
                  IconButton(
                      onPressed: () => viewModel.refresh(),
                      icon: const Icon(Icons.refresh))
              ],
            ),
            body: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : viewModel.hasError && viewModel.greenhousesNumber == 0
                    ? _buildError(context, viewModel)
                    : _buildGreenhousePages(context, viewModel)),
      );

  Widget _buildError(BuildContext context, HomeViewModel viewModel) => Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.basic_error),
          ElevatedButton(
              onPressed: () => viewModel.refresh(),
              style: ElevatedButton.styleFrom(primary: AppTheme.leafGreen),
              child: Text(AppLocalizations.of(context)!.retry))
        ],
      ));

  Widget _buildGreenhousePages(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.greenhousesNumber == 0) {
      return _buildNoGreenhouse(context, viewModel);
    }
    return Column(
      children: [
        Flexible(
          child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int newPage) {
                viewModel.setGreenhouse(newPage);
              },
              itemCount: viewModel.greenhousesNumber,
              itemBuilder: (BuildContext context, int index) =>
                  GreenhouseDetails(
                      greenhouse: viewModel.getGreenhouse(index))),
        ),
        TabPageSelector(indicatorSize: 8.0, controller: viewModel.tabController)
      ],
    );
  }

  Widget _buildNoGreenhouse(BuildContext context, HomeViewModel viewModel) =>
      Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.home_no_greenhouse,
              style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => viewModel.refresh(),
              style: ElevatedButton.styleFrom(primary: AppTheme.leafGreen),
              child: Text(AppLocalizations.of(context)!.retry))
        ],
      ));

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
