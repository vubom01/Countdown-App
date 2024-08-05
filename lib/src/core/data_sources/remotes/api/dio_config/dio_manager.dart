import 'package:dio/dio.dart';

import 'main_dio.dart';

abstract class DioConfig {
  Dio getDio({
    bool? showDialogError,
    Map<String, dynamic> addHeaders,
  });

  Map<String, String> customHeaders({Map<String, dynamic>? addHeaders});

  Interceptor customInterceptor();
}

class DioManager {
  const DioManager._();

  static Dio mainDio({bool? showDialogError, Map<String, dynamic>? addHeaders}) => MainDio().getDio(
        showDialogError: showDialogError,
        addHeaders: addHeaders,
      );
}
