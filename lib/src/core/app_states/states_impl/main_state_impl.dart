import 'dart:convert';

import 'package:countdown/src/app/domains/entities/user.dart';
import 'package:countdown/src/core/services/shared_prefs/shared_prefs.dart';
import 'package:tekflat_design/tekflat_design.dart';

import '../states/main_state.dart';

class MainStateImpl extends MainState {
  String _accessToken = '';
  User? _user;

  @override
  MainState init() {
    _accessToken = SharedPrefsService.to.getString(SharedPrefsServiceKeys.$accessToken);
    final userStr = SharedPrefsService.to.getString(SharedPrefsServiceKeys.$userInfo);
    try {
      if (userStr.isNotEmpty) {
        _user = User.fromJson(jsonDecode(userStr));
      }
    } catch (e) {
      TekLogger.errorLog('MainStateImpl init $e');
    }
    return this;
  }

  @override
  String get accessToken => _accessToken;

  @override
  User? get user => _user;

  @override
  bool get isLogin => _accessToken.isNotEmpty;

  @override
  void setAccessToken(String token) {
    setAccessTokenWithOutNotify(token);
    notifyListeners();
  }

  @override
  void setAccessTokenWithOutNotify(String token) {
    _accessToken = token;
    SharedPrefsService.to.setString(SharedPrefsServiceKeys.$accessToken, token);
  }

  @override
  void setUser(User user) {
    setUserWithOutNotify(user);
    notifyListeners();
  }

  @override
  void setUserWithOutNotify(User user) {
    _user = user;
    SharedPrefsService.to.setString(SharedPrefsServiceKeys.$userInfo, jsonEncode(user.toJson()));
  }

  @override
  void clearAccessTokenAndUser() {
    _accessToken = '';
    _user = null;
    SharedPrefsService.to.remove(SharedPrefsServiceKeys.$accessToken);
    SharedPrefsService.to.remove(SharedPrefsServiceKeys.$userInfo);
  }

  @override
  void login({
    required User user,
    required String token,
  }) {
    setAccessTokenWithOutNotify(token);
    setUserWithOutNotify(user);
    notifyListeners();
  }

  @override
  void logout() async {
    clearAccessTokenAndUser();
    notifyListeners();
  }
}
