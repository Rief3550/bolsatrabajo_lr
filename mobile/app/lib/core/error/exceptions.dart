class AppException implements Exception {
  final String message;
  final int statusCode;
  
  AppException({
    required this.message,
    required this.statusCode,
  });
  
  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class BadRequestException extends AppException {
  BadRequestException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class UnauthorizedException extends AppException {
  UnauthorizedException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class ForbiddenException extends AppException {
  ForbiddenException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class NotFoundException extends AppException {
  NotFoundException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class ConflictException extends AppException {
  ConflictException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class UnprocessableEntityException extends AppException {
  final Map<String, dynamic>? errors;
  
  UnprocessableEntityException({
    required String message,
    required int statusCode,
    this.errors,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class TimeoutException extends AppException {
  TimeoutException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class NetworkException extends AppException {
  NetworkException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class RequestCancelledException extends AppException {
  RequestCancelledException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class UnknownException extends AppException {
  UnknownException({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class CacheException extends AppException {
  CacheException({
    required String message,
  }) : super(
    message: message,
    statusCode: 0,
  );
}

