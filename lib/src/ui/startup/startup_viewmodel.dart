import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/constants/preference_flags.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/services/authentication_service.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:herbarium_mobile/src/core/services/preferences_service.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final PreferencesService _preferencesService = locator<PreferencesService>();

  final SimpleAnimation riveAnimationController =
      SimpleAnimation('Splash', autoplay: true);

  bool _animationIsActive = false;
  bool _textAnimationIsFinished = false;

  set textAnimationIsFinished(value) => _textAnimationIsFinished = value;
  bool _shadowAnimationIsFinished = false;

  set shadowAnimationIsFinished(value) => _shadowAnimationIsFinished = value;

  StartupViewModel() {
    riveAnimationController.isActiveChanged.addListener(() {
      _animationIsActive = riveAnimationController.isActive;
      silentSignIn();
    });
  }

  Future silentSignIn() async {
    if (!_animationIsActive &&
        _textAnimationIsFinished &&
        _shadowAnimationIsFinished) {
      String? provider = await _preferencesService
          .getString(PreferenceFlag.userSignInProvider);

      if (provider != null &&
          await _authenticationService.signIn(
              AuthenticationProvider.values
                  .firstWhere((element) => element.toString() == provider),
              silent: true)) {
        _navigationService.pushNamedAndRemoveUntil(path: NavigationRoute.home);
      } else {
        _navigationService.pushNamedAndRemoveUntil(path: NavigationRoute.login);
      }
    }
  }
}
