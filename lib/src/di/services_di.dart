import 'package:get_it/get_it.dart';
import 'package:countdown/src/core/services/app_stream/app_stream.dart';
import 'package:countdown/src/core/services/google_sign_in_service.dart';
import 'package:countdown/src/core/services/shared_prefs/shared_prefs.dart';

class ServicesDI {
  const ServicesDI._();

  static Future init(GetIt injector) async {
    injector.registerLazySingleton<AppStreamService>(AppStreamServiceImpl.init);
    injector.registerLazySingleton<GoogleSignInService>(GoogleSignInServiceImpl().init);
    injector.registerSingleton<SharedPrefsService>(await SharedPrefsServiceImpl().init());
  }
}
