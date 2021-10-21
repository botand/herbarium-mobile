import 'package:get_it/get_it.dart';
import 'package:herbarium_mobile/src/core/services/analytics_service.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/service/bluetooth_service.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => Logger());
  locator.registerLazySingleton(() => BluetoothService());
}
