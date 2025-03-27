import 'package:dio/dio.dart';
import 'package:flutter_job_marketplace/core/services/auth_service.dart';

class ApiInterceptor extends Interceptor {
  final AuthService _authService;
  
  ApiInterceptor(this._authService);
  
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authService.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    return handler.next(options);
  }
  
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      try {
        final refreshed = await _authService.refreshToken();
        
        if (refreshed) {
          // Retry the request with the new token
          final token = await _authService.getToken();
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $token';
          
          final response = await Dio().fetch(options);
          return handler.resolve(response);
        }
      } catch (e) {
        // Refresh token failed, logout
        await _authService.logout();
      }
    }
    
    return handler.next(err);
  }
}

