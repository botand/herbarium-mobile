import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/ui/home/home_view.dart';

class NavigationRouter {
  static final NavigationRouter instance = NavigationRouter();

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
        builder: (_) {
          switch (routeSettings.name) {
            case NavigationRoute.home:
              return const HomeView();
            default:
              return const Scaffold(body: Center(child: Text('Oups')));
          }
        },
        settings: routeSettings);
  }
}
