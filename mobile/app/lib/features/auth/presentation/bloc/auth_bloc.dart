import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/check_auth_status.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/login.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/logout.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatus checkAuthStatus;
  final Login login;
  final Logout logout;
  final Register register;
  
  AuthBloc({
    required this.checkAuthStatus,
    required this.login,
    required this.logout,
    required this.register,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RegisterEvent>(_onRegister);
  }
  
  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await checkAuthStatus();
    
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
  
  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await login(LoginParams(
      username: event.username,
      password: event.password,
    ));
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
  
  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await logout(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
  
  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await register(RegisterParams(
      name: event.name,
      lastName: event.lastName,
      email: event.email,
      username: event.username,
      password: event.password,
    ));
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) => emit(AuthRegistered()),
    );
  }
}

part 'auth_event.dart';
part 'auth_state.dart';

