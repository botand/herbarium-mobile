import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';

class BottomBar extends StatelessWidget {
  static const int _greenhousesView = 0;
  static const int _moreView = 1;

  final int _currentIndex;

  final NavigationService _navigationService = locator<NavigationService>();

  BottomBar({Key? key, required String currentRouteName})
      : _currentIndex = _defineIndex(currentRouteName),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _defineIndex(ModalRoute.of(context)!.settings.name!);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (value) => _onTap(value),
      items: _buildItems(context),
      selectedIconTheme: const IconThemeData(color: AppTheme.leafGreen),
      currentIndex: _currentIndex,
    );
  }

  static int _defineIndex(String routeName) {
    int currentIndex = _greenhousesView;

    switch (routeName) {
      case NavigationRoute.home:
      case NavigationRoute.setup:
        currentIndex = _greenhousesView;
        break;
      case NavigationRoute.more:
      case NavigationRoute.settings:
        currentIndex = _moreView;
        break;
    }

    return currentIndex;
  }

  void _onTap(int index) {
    if (index == _currentIndex) {
      return;
    }

    switch (index) {
      case _greenhousesView:
        _navigationService.pushNamed(NavigationRoute.home);
        break;
      case _moreView:
        _navigationService.pushNamed(NavigationRoute.more);
        break;
    }
  }

  List<BottomNavigationBarItem> _buildItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
          activeIcon: _buildIcon(Icons.home_outlined),
          icon: const Icon(Icons.home_outlined),
          label: AppLocalizations.of(context)!.title_home),
      BottomNavigationBarItem(
          activeIcon: _buildIcon(Icons.dehaze),
          icon: const Icon(Icons.dehaze),
          label: AppLocalizations.of(context)!.title_more),
    ];
  }

  Widget _buildIcon(IconData iconData) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white10),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
              child: Icon(iconData),
            )),
      );
}
