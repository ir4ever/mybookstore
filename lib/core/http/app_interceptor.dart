import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor extends Interceptor {
  final String? token;
  const AppInterceptor({this.token});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authToken = token ?? await _getToken();
    if (authToken != null) options.headers['Authorization'] = 'Bearer $authToken';
    super.onRequest(options, handler);
  }

  Future<String?> _getToken() async {
    final prefs = SharedPreferencesAsync();
    return prefs.getString('token');
  }
}
