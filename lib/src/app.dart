import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:herbarium_mobile/src/core/services/analytics_service.dart';
import 'package:herbarium_mobile/src/ui/startup/startup_view.dart';

import 'core/locator.dart';
import 'core/navigation_router.dart';
import 'core/utils/app_theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: AppTheme.theme(),
        onGenerateRoute: NavigationRouter.instance.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        navigatorObservers: [
          locator<AnalyticsService>().getAnalyticsObserver(),
        ],
        home: const StartupView());
  }
}
