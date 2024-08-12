import 'package:countdown/src/core/data_sources/locals/isar_db.dart';
import 'package:get_it/get_it.dart';
import 'package:countdown/src/core/services/shared_prefs/shared_prefs.dart';

class ServicesDI {
  const ServicesDI._();

  static Future init(GetIt injector) async {
    injector.registerSingleton<SharedPrefsService>(await SharedPrefsServiceImpl().init());
    injector.registerSingleton<IsarDB>(await IsarDBImpl().init());
  }
}
