import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/ui/startup/startup_viewmodel.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  double _textOpacity = 0;
  double _shadowOpacity = 0.75;

  final Duration _textAnimationDuration = const Duration(seconds: 2);
  final Duration _textAnimationDelay = const Duration(seconds: 2);
  final Duration _shadowAnimationDuration =
      const Duration(seconds: 1, milliseconds: 500);
  final Duration _shadowAnimationDelay = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();

    if(Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    Future.delayed(_textAnimationDelay, () => setState(() => _textOpacity = 1));
    Future.delayed(
        _shadowAnimationDelay, () => setState(() => _shadowOpacity = 0));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, StartupViewModel viewmodel, child) => Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              RiveAnimation.asset(
                  'assets/animations/herbarium_splash_screen_animation.riv',
                  controllers: [viewmodel.riveAnimationController],
                  alignment: Alignment.bottomCenter),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: AnimatedOpacity(
                        duration: _textAnimationDuration,
                        opacity: _textOpacity,
                        onEnd: () {
                          viewmodel.textAnimationIsFinished = true;
                          viewmodel.navigateToHomeScreen();
                        },
                        child: Text(AppLocalizations.of(context)!.appTitle,
                            style: Theme.of(context).textTheme.headline1!.copyWith(
                                fontFamily: 'RougeScript', color: Colors.white)),
                      ))),
              AnimatedOpacity(
                  duration: _shadowAnimationDuration,
                  opacity: _shadowOpacity,
                  onEnd: () {
                    viewmodel.shadowAnimationIsFinished = true;
                    viewmodel.navigateToHomeScreen();
                  },
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black))
            ],
      )),
    );
  }
}
