import 'package:shared_preferences/shared_preferences.dart';
import 'package:countdown/src/di/app_injector.dart';

abstract class SharedPrefsService {
  static SharedPrefsService get to => AppInjector.injector<SharedPrefsService>();

  Future<SharedPrefsService> init();

  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<bool> setList(String key, List<String> values);

  String getString(String key);

  bool getBool(String key);

  List<String> getList(String key);

  Future<bool> remove(String key);

  Future<bool> clear();

  Map<String, dynamic> get allPrefs;
}

class SharedPrefsServiceImpl implements SharedPrefsService {
  late final SharedPreferences _prefs;

  @override
  Future<SharedPrefsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  @override
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<bool> setList(String key, List<String> values) => _prefs.setStringList(key, values);

  @override
  String getString(String key) => _prefs.getString(key) ?? '';

  @override
  bool getBool(String key) => _prefs.getBool(key) ?? false;

  @override
  List<String> getList(String key) => _prefs.getStringList(key) ?? [];

  @override
  Future<bool> remove(String key) => _prefs.remove(key);

  @override
  Future<bool> clear() => _prefs.clear();

  @override
  Map<String, dynamic> get allPrefs => _prefs.getKeys().fold<Map<String, dynamic>>(
        {},
        (Map<String, dynamic> previousValue, String element) {
          previousValue[element] = _prefs.get(element);
          return previousValue;
        },
      );
}
