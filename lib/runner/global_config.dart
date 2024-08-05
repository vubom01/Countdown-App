import 'package:flutter/material.dart';
import 'package:countdown/src/core/helpers/json_file.dart';
import 'package:countdown/src/core/styles/fonts.dart';
import 'package:countdown/src/di/app_injector.dart';
import 'package:tekflat_design/tekflat_design.dart';

import 'app_mode.dart';

class GlobalConfig {
  const GlobalConfig._();

  static final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

  static Future initApp({required String env}) async {
    await _configAppMode(env: env);

    _systemUI();
    await _appInjection();
  }

  static void _systemUI() {
    TekFonts().setDefaultFont(FontsStyles.primaryFont);
    TekFonts().setFonts(
      body: FontsStyles.primaryFont,
      label: FontsStyles.primaryFont,
      title: FontsStyles.primaryFont,
      headline: FontsStyles.primaryFont,
      display: FontsStyles.primaryFont,
    );
  }

  static Future _configAppMode({required String env}) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await TekLoadEnv.init(envFile: env);
      await Future.wait(
        [
          AppRunnerConfig.initAppMode(),
          AppRunnerConfig.initMainColor(),
        ],
      );
    } catch (e) {
      TekLogger.errorLog("initApp config error: $e");
    }
  }

  static Future _appInjection() async => AppInjector.initializeDependencies();
}

class AppRunnerConfig {
  const AppRunnerConfig._();

  static Future initAppMode() async {
    try {
      final String environment = TekLoadEnv.get(key: 'ENVIRONMENT');
      if (environment.isEmpty) return;
      late final Flavor flavor;
      if (environment.toLowerCase() == Flavor.dev.name) {
        flavor = Flavor.dev;
      } else if (environment.toLowerCase() == Flavor.stage.name) {
        flavor = Flavor.stage;
      } else if (environment.toLowerCase() == Flavor.prod.name) {
        flavor = Flavor.prod;
      } else {
        return;
      }
      var apiConfig = await JsonFileHelpers.readAssetsJsonFile("config_app/api_config.json");
      apiConfig = Map<String, dynamic>.from(apiConfig).cast<String, dynamic>();
      final String baseUrl = apiConfig[environment]?['API_URL'] ?? '';
      if (baseUrl.isEmpty) return;
      Map<String, String> services = {};
      if (apiConfig[environment]?['SERVICES'] != null) {
        services =
            Map<String, String>.from(apiConfig[environment]?['SERVICES']).cast<String, String>();
      }
      AppMode().setAppMode(
        FlavorMode(
          flavor: flavor,
          baseUrl: baseUrl,
          services: services,
        ),
      );
    } catch (e) {
      TekLogger.errorLog("initAppMode: $e}");
    }
  }

  static Future initMainColor() async {
    try {
      final String theme = TekLoadEnv.get(key: 'THEME');
      if (theme.isEmpty) return;
      final Map<String, dynamic> themeConfig =
          await JsonFileHelpers.readAssetsJsonFile("config_app/theme_config.json")
              as Map<String, dynamic>;
      final String strPrimary = themeConfig[theme]?['PRIMARY'] ?? '';
      final String strPrimaryDark = themeConfig[theme]?['PRIMARY_DARK'] ?? '';
      final String strPrimaryLight = themeConfig[theme]?['PRIMARY_LIGHT'] ?? '';
      if (strPrimary.isEmpty || strPrimaryDark.isEmpty || strPrimaryLight.isEmpty) return;
      final Color primary = Color(int.parse(strPrimary, radix: 16));
      final Color primaryDark = Color(int.parse(strPrimaryDark, radix: 16));
      final Color primaryLight = Color(int.parse(strPrimaryLight, radix: 16));
      TekColors().setColors(
        primary: primary,
        primaryLight: primaryLight,
        primaryDark: primaryDark,
      );
      Color? bgPrimaryThemeDark;
      final String strBgPrimaryThemeDark = themeConfig[theme]?['BG_PRIMARY_THEME_DARK'] ?? '';
      if (strBgPrimaryThemeDark.isNotEmpty) {
        bgPrimaryThemeDark = Color(int.parse(strBgPrimaryThemeDark, radix: 16));
      }
      Color? bgPrimaryThemeLight;
      final String strBgPrimaryThemeLight = themeConfig[theme]?['BG_PRIMARY_THEME_LIGHT'] ?? '';
      if (strBgPrimaryThemeLight.isNotEmpty) {
        bgPrimaryThemeLight = Color(int.parse(strBgPrimaryThemeLight, radix: 16));
      }
      Color? bgSecondaryThemeDark;
      final String strBgSecondaryThemeDark = themeConfig[theme]?['BG_SECONDARY_THEME_DARK'] ?? '';
      if (strBgSecondaryThemeDark.isNotEmpty) {
        bgSecondaryThemeDark = Color(int.parse(strBgSecondaryThemeDark, radix: 16));
      }
      Color? bgSecondaryThemeLight;
      final String strBgSecondaryThemeLight = themeConfig[theme]?['BG_SECONDARY_THEME_LIGHT'] ?? '';
      if (strBgSecondaryThemeLight.isNotEmpty) {
        bgSecondaryThemeLight = Color(int.parse(strBgSecondaryThemeLight, radix: 16));
      }
      TekColors().setBgColors(
        bgPrimaryThemeDark: bgPrimaryThemeDark,
        bgPrimaryThemeLight: bgPrimaryThemeLight,
        bgSecondaryThemeDark: bgSecondaryThemeDark,
        bgSecondaryThemeLight: bgSecondaryThemeLight,
      );
    } catch (e) {
      TekLogger.errorLog("initMainColor: $e}");
    }
  }
}
