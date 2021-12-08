import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/services/authentication_service.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class MoreViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signOut() async {
    await _authenticationService.signOut();
    _navigationService.pushNamedAndRemoveUntil(path: NavigationRoute.login);
  }
}
