import 'package:dio/dio.dart';
import 'package:flutter_job_marketplace/core/api/api_interceptor.dart';
import 'package:flutter_job_marketplace/core/config/app_config.dart';
import 'package:flutter_job_marketplace/core/error/exceptions.dart';

class ApiClient {
  final ApiInterceptor _interceptor;
  late final Dio _dio;
  
  ApiClient(this._interceptor) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    _dio.interceptors.add(_interceptor);
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }
  
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        return response.data;
      case 400:
        throw BadRequestException(
          message: response.data['message'] ?? 'Bad request',
          statusCode: response.statusCode,
        );
      case 401:
        throw UnauthorizedException(
          message: response.data['message'] ?? 'Unauthorized',
          statusCode: response.statusCode,
        );
      case 403:
        throw ForbiddenException(
          message: response.data['message'] ?? 'Forbidden',
          statusCode: response.statusCode,
        );
      case 404:
        throw NotFoundException(
          message: response.data['message'] ?? 'Not found',
          statusCode: response.statusCode,
        );
      case 409:
        throw ConflictException(
          message: response.data['message'] ?? 'Conflict',
          statusCode: response.statusCode,
        );
      case 422:
        throw UnprocessableEntityException(
          message: response.data['message'] ?? 'Unprocessable entity',
          statusCode: response.statusCode,
          errors: response.data['errors'],
        );
      case 500:
      case 501:
      case 502:
      case 503:
        throw ServerException(
          message: response.data['message'] ?? 'Server error',
          statusCode: response.statusCode,
        );
      default:
        throw UnknownException(
          message: response.data['message'] ?? 'Unknown error',
          statusCode: response.statusCode,
        );
    }
  }
  
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Connection timeout',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        return _handleResponse(error.response!);
      case DioExceptionType.cancel:
        return RequestCancelledException(
          message: 'Request cancelled',
          statusCode: 499,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection',
          statusCode: 0,
        );
      default:
        return UnknownException(
          message: error.message ?? 'Unknown error',
          statusCode: 0,
        );
    }
  }
}

