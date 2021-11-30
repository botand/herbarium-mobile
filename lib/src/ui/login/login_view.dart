import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/ui/login/widgets/sign_in_with_button.dart';
import 'package:herbarium_mobile/src/ui/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static const bool disableAppleSignIn = true;

  @override
  Widget build(BuildContext context) => ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(AppLocalizations.of(context)!),
        builder: (BuildContext context, LoginViewModel viewModel,
                Widget? child) =>
            BaseScaffold(
                isInteractionLimitedWhileLoading: true,
                isLoading: viewModel.isBusy,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Text(AppLocalizations.of(context)!.appTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontFamily: 'RougeScript',
                                  color: Colors.white)),
                      Text(AppLocalizations.of(context)!.login,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 32)),
                      const Spacer(flex: 3),
                      SignInWithButton(
                        provider: AppLocalizations.of(context)!.login_google,
                        onPressed: () => viewModel.signInWithGoogle(),
                        leading: Image.asset("assets/images/google_logo.png",
                            height: 32),
                        backgroundColor: Colors.white,
                        textColor: Colors.black38,
                      ),
                      const SizedBox(height: 30),
                      if (Platform.isIOS && disableAppleSignIn)
                        SignInWithButton(
                          provider: AppLocalizations.of(context)!.login_apple,
                          leading: Image.asset("assets/images/apple_logo.png",
                              height: 32),
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        ),
                      const Spacer(flex: 1),
                      Image.asset("assets/images/plant_in_pot.png")
                    ],
                  ),
                )),
      );
}
