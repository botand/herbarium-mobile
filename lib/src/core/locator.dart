import 'package:get_it/get_it.dart';
import 'package:herbarium_mobile/src/core/services/analytics_service.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AnalyticsService());
}
