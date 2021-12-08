import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RingLedAnimated extends StatelessWidget {
  static const _riveFile = "assets/animations/ring_led_animations.riv";
  final RingPattern pattern;

  const RingLedAnimated({Key? key, this.pattern = RingPattern.solidLeafGreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) => RiveAnimation.asset(
        _riveFile,
        fit: BoxFit.fitHeight,
        animations: [pattern.toShortString()],
        // controllers: [_controller],
      );
}

enum RingPattern {
  solidRed,
  solidBlue,
  solidGreen,
  solidLeafGreen,
  solidViolet,
  solidOrange,
  blinkingRed,
  blinkingBlue,
  blinkingGreen,
  blinkingLeafGreen,
  blinkingViolet,
  blinkingOrange,
  breathingRed,
  breathingBlue,
  breathingGreen,
  breathingLeafGreen,
  breathingViolet,
  breathingOrange,
  spinningRed,
  spinningBlue,
  spinningGreen,
  spinningLeafGreen,
  spinningViolet,
  spinningOrange,
}

extension ParseToString on RingPattern {
  String toShortString() {
    return toString().split('.').last;
  }
}
