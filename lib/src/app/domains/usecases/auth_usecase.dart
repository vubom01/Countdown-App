import 'package:countdown/src/di/app_injector.dart';

class AuthUseCase {
  static AuthUseCase get to => AppInjector.injector<AuthUseCase>();
}
