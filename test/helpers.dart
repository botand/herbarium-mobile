import 'package:herbarium_mobile/src/core/locator.dart';

/// Return the path of the [goldenName] file.
String goldenFilePath(String goldenName) => "./goldenFiles/$goldenName.png";

/// Unregister the service [T] from GetIt
void unregister<T>() {
  if (locator.isRegistered<Object>()) {
    locator.unregister<Object>();
  }
}
