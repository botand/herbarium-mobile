import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/services/authentication_service.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  
  final NavigationService _navigationService = locator<NavigationService>();

  final AppLocalizations appLocalizations;

  LoginViewModel(this.appLocalizations);

  Future<void> signInWithGoogle() async {
    setBusy(true);
    if(await _authenticationService.signIn(AuthenticationProvider.google)) {
      _navigationService.pushNamedAndRemoveUntil(path: NavigationRoute.home);
    } else {
      Fluttertoast.showToast(msg: appLocalizations.login_failed);
    }
    setBusy(false);
  }
}
