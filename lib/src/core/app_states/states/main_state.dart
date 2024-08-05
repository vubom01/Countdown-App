import 'package:flutter/material.dart';
import 'package:countdown/src/app/domains/entities/user.dart';
import 'package:countdown/src/di/app_injector.dart';

abstract class MainState extends ChangeNotifier {
  static MainState get to => AppInjector.injector<MainState>();

  MainState init();

  String get accessToken;

  User? get user;

  bool get isLogin;

  void setAccessToken(String token);

  void setAccessTokenWithOutNotify(String token);

  void setUser(User user);

  void setUserWithOutNotify(User user);

  void clearAccessTokenAndUser();

  void login({
    required User user,
    required String token,
  });

  void logout();
}
