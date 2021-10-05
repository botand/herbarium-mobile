import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';

class NavigationRouter {
  static final NavigationRouter instance = NavigationRouter();

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) {
        switch (routeSettings.name) {
          case NavigationRoute.login:
          default:
            return const Scaffold(body: Center(child: Text('Oups')));
        }
      }
    );
  }
}
