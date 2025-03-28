import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/check_auth_status.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/google_login.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/login.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/logout.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/register.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/reset_password.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/verify_email.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatus checkAuthStatus;
  final Login login;
  final Logout logout;
  final Register register;
  final GoogleLogin googleLogin;
  final VerifyEmail verifyEmail;
  final ForgotPassword forgotPassword;
  final ResetPassword resetPassword;

  AuthBloc({
    required this.checkAuthStatus,
    required this.login,
    required this.logout,
    required this.register,
    required this.googleLogin,
    required this.verifyEmail,
    required this.forgotPassword,
    required this.resetPassword,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RegisterEvent>(_onRegister);
    on<GoogleLoginEvent>(_onGoogleLogin);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await checkAuthStatus(const NoParams());
    
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
    
    // Imprimir las credenciales para depuración
    print('Intentando iniciar sesión con: ${event.username} / ${event.password}');
    
    final result = await login(LoginParams(
      username: event.username,
      password: event.password,
    ));
    
    result.fold(
      (failure) {
        print('Error de inicio de sesión: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {
        print('Inicio de sesión exitoso: ${user.name}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await logout(const NoParams());
    
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
      (_) => emit(AuthRegistered()),
    );
  }

  Future<void> _onGoogleLogin(
    GoogleLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await googleLogin(const NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onVerifyEmail(
    VerifyEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await verifyEmail(VerifyEmailParams(token: event.token));
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(EmailVerified()),
    );
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await forgotPassword(ForgotPasswordParams(email: event.email));
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(PasswordResetEmailSent()),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await resetPassword(ResetPasswordParams(
      token: event.token,
      newPassword: event.newPassword,
    ));
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(PasswordReset()),
    );
  }
}

