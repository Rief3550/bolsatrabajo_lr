import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;
  
  const Failure({
    required this.message,
    required this.statusCode,
  });
  
  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
  }) : super(
    message: message,
    statusCode: 0,
  );
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;
  
  const ValidationFailure({
    required String message,
    required int statusCode,
    this.errors,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
  
  @override
  List<Object> get props => [message, statusCode, if (errors != null) errors!];
}

class AuthFailure extends Failure {
  const AuthFailure({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required String message,
    required int statusCode,
  }) : super(
    message: message,
    statusCode: statusCode,
  );
}

