import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoneStep extends StatelessWidget {
  final VoidCallback? onTapDone;

  const DoneStep(
      {Key? key,
      required this.onTapDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height / 6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.all_done,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: cardHeight,
              child: Stack(alignment: Alignment.bottomRight, children: const []),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: onTapDone,
                child: Text(AppLocalizations.of(context)!.done.toUpperCase()))
          ],
        )
      ],
    );
  }
}
