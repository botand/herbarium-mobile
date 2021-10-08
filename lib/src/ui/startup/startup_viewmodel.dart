import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

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
      navigateToHomeScreen();
    });
  }

  void navigateToHomeScreen() {
    if (!_animationIsActive &&
        _textAnimationIsFinished &&
        _shadowAnimationIsFinished) {
      _navigationService.pushNamedAndRemoveUntil(path: NavigationRoute.home);
    }
  }
}
