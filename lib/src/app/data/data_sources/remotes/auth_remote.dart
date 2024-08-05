import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:countdown/src/core/data_sources/remotes/api/api.dart';

part 'auth_remote.g.dart';

@RestApi()
abstract class AuthRemote {
  static AuthRemote call({
    bool? showDialogError,
    Map<String, dynamic>? addHeaders,
  }) =>
      _AuthRemote(
        DioManager.mainDio(
          showDialogError: showDialogError,
          addHeaders: addHeaders,
        ),
      );
}
