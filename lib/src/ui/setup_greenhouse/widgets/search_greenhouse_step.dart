import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/ui/base/ring_led_animated.dart';

class SearchGreenhouseStep extends StatelessWidget {
  const SearchGreenhouseStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.setup_device_searching,
                style: Theme.of(context).textTheme.headline5),
            const Flexible(
                child: FractionallySizedBox(
              heightFactor: 0.1,
            )),
            const CircularProgressIndicator(),
            const Flexible(
                child: FractionallySizedBox(
              heightFactor: 0.7,
            )),
            Container(
              width: 350,
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.white, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .setup_device_searching_tip,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 50,
                        height: 50,
                        child: RingLedAnimated(
                          pattern: RingPattern.blinkingOrange,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
