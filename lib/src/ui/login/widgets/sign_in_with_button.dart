import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInWithButton extends StatelessWidget {
  /// Background color of the button.
  final Color? backgroundColor;

  /// Color of the text.
  final Color? textColor;

  /// Widget that will be displayed in front of the button.
  final Widget leading;

  /// Name of the provider e.g. Google.
  final String provider;

  /// Callback to call when the button is pressed.
  final VoidCallback? onPressed;

  const SignInWithButton(
      {Key? key,
      required this.provider,
      required this.leading,
      this.textColor,
      this.backgroundColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0)),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: leading,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(AppLocalizations.of(context)!.login_sign_with(provider),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: textColor)),
          )
        ],
      ));
}
