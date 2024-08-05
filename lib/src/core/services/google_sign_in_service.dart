import 'package:google_sign_in/google_sign_in.dart';
import 'package:countdown/src/di/app_injector.dart';

abstract class GoogleSignInService {
  static GoogleSignInService get to => AppInjector.injector<GoogleSignInService>();

  GoogleSignInService init();

  Future<GoogleSignInAccount?> signIn();

  Future<GoogleSignInAccount?> signOut();

  GoogleSignInAccount? get currentUser;
}

class GoogleSignInServiceImpl implements GoogleSignInService {
  late final GoogleSignIn _googleSignIn;

  @override
  GoogleSignInService init() {
    _googleSignIn = GoogleSignIn();
    return this;
  }

  @override
  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();

  @override
  Future<GoogleSignInAccount?> signOut() => _googleSignIn.signOut();

  @override
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}
