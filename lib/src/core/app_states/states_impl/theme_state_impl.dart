import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:countdown/src/core/services/shared_prefs/shared_prefs.dart';
import 'package:tekflat_design/tekflat_design.dart';

import '../states/theme_state.dart';

class ThemeStateImpl extends ThemeState {
  late MapEntry<ThemeMode, ThemeData> _currentTheme;

  @override
  ThemeState init() {
    _currentTheme = ThemeState.themes.entries.firstWhereOrNull(
          (element) =>
              element.key.toString() ==
              SharedPrefsService.to.getString(SharedPrefsServiceKeys.$theme),
        ) ??
        ThemeState.themes.entries.first;

    _changeStatusBar();

    return this;
  }

  @override
  ThemeData get currentTheme => _currentTheme.value;

  @override
  ThemeMode get currentThemeMode => _currentTheme.key;

  @override
  void setCurrentTheme(ThemeMode appThemeMode) {
    if (appThemeMode == _currentTheme.key) return;
    switch (appThemeMode) {
      case ThemeMode.light:
        _currentTheme = MapEntry(ThemeMode.light, TekThemes.light);
        break;
      case ThemeMode.dark:
        _currentTheme = MapEntry(ThemeMode.dark, TekThemes.dark);
        break;
      case ThemeMode.system:
        _currentTheme = MapEntry(ThemeMode.light, TekThemes.light);
        break;
    }
    SharedPrefsService.to.setString(SharedPrefsServiceKeys.$theme, appThemeMode.toString());
    _changeStatusBar();
    notifyListeners();
  }

  void _changeStatusBar() {
    final systemUI = SystemUiOverlayStyle(
      statusBarColor: TekColors().primary,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: TekColors().primary,
    );

    if (TekPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(systemUI);
    } else {
      if (_currentTheme.key == ThemeMode.light) {
        SystemChrome.setSystemUIOverlayStyle(systemUI);
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          systemUI.copyWith(
            statusBarBrightness: Brightness.dark,
          ),
        );
      }
    }
  }
}
