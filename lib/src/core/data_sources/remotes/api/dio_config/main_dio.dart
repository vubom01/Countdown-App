import 'package:dio/dio.dart';
import 'package:countdown/runner/app_mode.dart';
import 'package:countdown/src/core/app_states/states/main_state.dart';
import 'package:tekflat_design/tekflat_design.dart';

import '../api_config/api_config.dart';
import 'dio_config.dart';

class MainDio extends DioConfig {
  bool? _showDialogError;

  @override
  Dio getDio({
    bool? showDialogError,
    Map<String, dynamic>? addHeaders,
  }) {
    _showDialogError = showDialogError;
    final String baseUrl = AppMode().appMode.baseUrl;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: customHeaders(addHeaders: addHeaders),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    Dio dio = Dio(options);

    dio.interceptors.add(customInterceptor());

    return dio;
  }

  @override
  Map<String, String> customHeaders({Map<String, dynamic>? addHeaders}) {
    var headers = <String, String>{};
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';
    if (MainState.to.isLogin) headers['access-token'] = MainState.to.accessToken;
    if (addHeaders != null) {
      for (var element in addHeaders.entries) {
        headers[element.key] = element.value;
      }
    }
    return headers;
  }

  @override
  Interceptor customInterceptor() => _MainDioInterceptor(showDialogError: _showDialogError ?? true);
}

class _MainDioInterceptor implements Interceptor {
  const _MainDioInterceptor({this.showDialogError = true}) : super();

  final bool? showDialogError;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    TekLogger.errorLog('onError');
    TekLogger.errorLog(err.requestOptions.uri);
    TekLogger.errorLog(err.message);
    int? statusCode = err.response?.statusCode;
    String message = err.response?.data['message'] ?? err.message;
    switch (statusCode) {
      case ApiCode.tokenNotFound:
        MainState.to.logout();
        break;
      case ApiCode.invalidToken:
        MainState.to.logout();
        break;
      case ApiCode.expiredToken:
        MainState.to.logout();
        break;
      case ApiCode.userSignedOut:
        MainState.to.logout();
        break;
      case ApiCode.notAllowedDevice:
        MainState.to.logout();
        break;
      case ApiCode.userSignedInAnotherLocation:
        MainState.to.logout();
        break;
      default:
        break;
    }
    TekToast.error(msg: message);
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    TekLogger.debugLog('onResponse');
    TekLogger.debugLog(response);
    int? statusCode = response.data['code'] ?? response.statusCode;
    switch (statusCode) {
      case ApiCode.tokenNotFound:
        MainState.to.logout();
        break;
      case ApiCode.invalidToken:
        MainState.to.logout();
        break;
      case ApiCode.expiredToken:
        MainState.to.logout();
        break;
      case ApiCode.userSignedOut:
        MainState.to.logout();
        break;
      case ApiCode.notAllowedDevice:
        MainState.to.logout();
        break;
      case ApiCode.userSignedInAnotherLocation:
        MainState.to.logout();
        break;
      default:
        break;
    }
    return handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    TekLogger.infoLog('onRequest');
    TekLogger.infoLog(options.uri);
    TekLogger.infoLog(options.data);
    TekLogger.infoLog(options.headers);
    return handler.next(options);
  }
}
