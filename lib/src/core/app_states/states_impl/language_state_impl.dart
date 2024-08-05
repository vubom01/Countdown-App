import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:countdown/src/core/services/shared_prefs/shared_prefs.dart';

import '../states/language_state.dart';

class LanguageStateImpl extends LanguageState {
  late Locale _locale;

  @override
  LanguageState init() {
    // 0 - English , 1 - Vietnamese
    _locale = S.delegate.supportedLocales.firstWhereOrNull(
          (locale) =>
              locale.languageCode ==
              SharedPrefsService.to.getString(SharedPrefsServiceKeys.$language),
        ) ??
        S.delegate.supportedLocales[0];
    return this;
  }

  @override
  void setCurrentLocale(Locale locale) async {
    if (_locale.languageCode == locale.languageCode) return;
    _locale = locale;
    await Future.wait(
      [
        S.load(_locale),
        SharedPrefsService.to.setString(SharedPrefsServiceKeys.$language, locale.languageCode),
      ],
    );
    notifyListeners();
  }

  @override
  Locale get currentLocale => _locale;
}
