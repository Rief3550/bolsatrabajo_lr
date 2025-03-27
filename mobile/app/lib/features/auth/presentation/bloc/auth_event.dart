part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  
  const LoginEvent({
    required this.username,
    required this.password,
  });
  
  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String name;
  final String lastName;
  final String email;
  final String username;
  final String password;
  
  const RegisterEvent({
    required this.name,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });
  
  @override
  List<Object> get props => [name, lastName, email, username, password];
}

