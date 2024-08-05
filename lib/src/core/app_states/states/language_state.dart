import 'package:flutter/material.dart';
import 'package:countdown/src/di/app_injector.dart';

abstract class LanguageState extends ChangeNotifier {
  static LanguageState get to => AppInjector.injector<LanguageState>();

  LanguageState init();

  Locale get currentLocale;

  void setCurrentLocale(Locale locale);
}
