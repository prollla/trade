import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String? authToken;

  AuthInterceptor(this.authToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authToken != null) {
      options.headers["Authorization"] = "Bearer $authToken";
    }
    super.onRequest(options, handler);
  }
}