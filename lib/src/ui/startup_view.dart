import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  double _textOpacity = 0;
  double _shadowOpacity = 0.75;

  @override
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(seconds: 2), () => setState(() => _textOpacity = 1));
    Future.delayed(const Duration(milliseconds: 100),
        () => setState(() => _shadowOpacity = 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        const RiveAnimation.asset(
            'assets/animations/herbarium_splash_screen_animation.riv',
            alignment: Alignment.bottomCenter),
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: _textOpacity,
                  child: Text(AppLocalizations.of(context)!.appTitle,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontFamily: 'RougeScript', color: Colors.white)),
                ))),
        AnimatedOpacity(
            duration: const Duration(seconds: 1, milliseconds: 500),
            opacity: _shadowOpacity,
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black))
      ],
    ));
  }
}
