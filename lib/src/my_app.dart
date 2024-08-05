import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:countdown/runner/global_config.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:tekflat_design/tekflat_design.dart';

import 'core/app_states/states/language_state.dart';
import 'core/app_states/states/main_state.dart';
import 'core/app_states/states/theme_state.dart';
import 'core/router/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageState>(
          create: (_) => LanguageState.to,
        ),
        ChangeNotifierProvider<ThemeState>(
          create: (_) => ThemeState.to,
        ),
        ChangeNotifierProvider<MainState>(
          create: (_) => MainState.to,
        ),
      ],
      builder: (newContext, child) {
        Provider.of<LanguageState>(newContext, listen: true);
        Provider.of<ThemeState>(newContext, listen: true);
        Provider.of<MainState>(newContext, listen: true);
        return MaterialApp.router(
          title: 'Countdown App',
          builder: TekLoading.appLoading.initLoading,
          scaffoldMessengerKey: GlobalConfig.snackBarKey,
          debugShowCheckedModeBanner: true,
          routerConfig: AppRouter.to.router,
          theme: TekThemes.light,
          darkTheme: TekThemes.dark,
          themeMode: ThemeState.to.currentThemeMode,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: LanguageState.to.currentLocale,
        );
      },
    );
  }
}
