import 'package:go_router/go_router.dart';
import 'package:countdown/src/di/app_injector.dart';

import 'app_routes.dart';

abstract class AppRouter {
  static AppRouter get to => AppInjector.injector<AppRouter>();

  AppRouter init();

  GoRouter get router;

  AppRoutes? get currentAppRoutes;
}
