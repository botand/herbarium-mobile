import 'package:flutter/material.dart';

/// Navigation service who doesn't use the BuildContext which allow us to call it from anywhere.
class NavigationService {
  static final NavigationService _instance = NavigationService();
  static NavigationService get instance => _instance;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Pop the last route of the navigator if possible
  bool pop() {
    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.pop();
      return true;
    }
    return false;
  }

  /// Push a restorable named route ([routeName] onto the navigator.
  String restorablePushNamed(String routeName, {Object? arguments}) {
    return _navigatorKey.currentState!
        .restorablePushNamed(routeName, arguments: arguments);
  }

  /// Push a named route ([routeName] onto the navigator.
  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then delete the stack of previous routes
  Future<void> pushNamedAndRemoveUntil(
      {String? path, Object? data, String? removeUntilRouteNamed}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
        path!,
        (Route<dynamic> route) => removeUntilRouteNamed != null
            ? route.settings.name == removeUntilRouteNamed
            : false,
        arguments: data);
  }
}
