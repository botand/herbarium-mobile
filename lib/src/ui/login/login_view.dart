import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/ui/login/widgets/sign_in_with_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseScaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Text(AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontFamily: 'RougeScript', color: Colors.white)),
            const Spacer(flex: 1),
            Text(AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 32)),
            const Spacer(flex: 1),
            SignInWithButton(
              provider: AppLocalizations.of(context)!.login_google,
              leading: Image.asset("assets/images/google_logo.png", height: 32),
              backgroundColor: Colors.white,
              textColor: Colors.black38,
            ),
            const SizedBox(height: 30),
            SignInWithButton(
              provider: AppLocalizations.of(context)!.login_apple,
              leading: Image.asset("assets/images/apple_logo.png", height: 32),
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
            Image.asset("assets/images/plant_in_pot.png")
          ],
        ),
      ));
}
