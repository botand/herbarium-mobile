import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/models/plant.dart';
import 'package:herbarium_mobile/src/ui/home/home_view.dart';
import 'package:herbarium_mobile/src/ui/login/login_view.dart';
import 'package:herbarium_mobile/src/ui/plant_details/plant_details_view.dart';
import 'package:herbarium_mobile/src/ui/settings/more_view.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/setup_greenhouse_view.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/models/setup_plant_arguments.dart';
import 'package:herbarium_mobile/src/ui/setup_new_plant/setup_plant_view.dart';

class NavigationRouter {
  static final NavigationRouter instance = NavigationRouter();

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    return PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          switch (routeSettings.name) {
            case NavigationRoute.home:
              return const HomeView();
            case NavigationRoute.plantDetails:
              return PlantDetailsView(plant: routeSettings.arguments as Plant);
            case NavigationRoute.login:
              return const LoginView();
            case NavigationRoute.setupPlant:
              final arguments = routeSettings.arguments as SetupPlantArguments;
              return SetupPlantView(
                  plant: arguments.plant, greenhouse: arguments.greenhouse);
            case NavigationRoute.setup:
              return const SetupGreenHouseView();
            case NavigationRoute.more:
              return const MoreView();
            default:
              return const Scaffold(body: Center(child: Text('Oups')));
          }
        },
        settings: routeSettings);
  }
}
