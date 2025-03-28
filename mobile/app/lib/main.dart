import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_job_marketplace/providers/auth_provider.dart';
import 'package:flutter_job_marketplace/providers/job_provider.dart';
import 'package:flutter_job_marketplace/providers/notification_provider.dart';
import 'package:flutter_job_marketplace/providers/theme_provider.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/screens/splash/splash_screen.dart';
import 'package:flutter_job_marketplace/theme/app_theme.dart';
import 'package:flutter_job_marketplace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/check_auth_status.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/login.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/logout.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/register.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/google_login.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/verify_email.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/reset_password.dart';

// Implementación simple del repositorio de autenticación
class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, bool>> agreeToConfidentiality() async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, UserModel>> checkAuthStatus() async {
    return Right(UserModel(
      id: '123',
      username: 'user123',
      name: 'Juan',
      lastName: 'Pérez',
      email: 'juan@example.com',
      address: 'Calle Principal 123',
      age: 30,
      profileType: 'Prestación',
      isPhysicalPerson: true,
      isNonPhysicalPerson: false,
      requestedProfessions: ['Mecánico'],
      contractionType: 'Permanente',
      rating: 4.5,
      isBlocked: false,
      isAvailable: true,
      hasAgreedToConfidentiality: true,
    ));
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, UserModel>> googleLogin() async {
    return Right(UserModel(
      id: '123',
      username: 'google_user',
      name: 'Google',
      lastName: 'User',
      email: 'google@example.com',
      address: 'Google Street 123',
      age: 30,
      profileType: 'Prestación',
      isPhysicalPerson: true,
      isNonPhysicalPerson: false,
      requestedProfessions: ['Mecánico'],
      contractionType: 'Permanente',
      rating: 4.5,
      isBlocked: false,
      isAvailable: true,
      hasAgreedToConfidentiality: true,
    ));
  }

  @override
  Future<Either<Failure, UserModel>> login(String username, String password) async {
    // Imprimir las credenciales para depuración
    print('Repositorio recibió: $username / $password');
    
    // Verificar las credenciales de forma más explícita
    if (username == 'admin' && password == 'admin') {
      print('Credenciales válidas en el repositorio');
      return Right(UserModel(
        id: '123',
        username: username,
        name: 'Juan',
        lastName: 'Pérez',
        email: 'juan@example.com',
        address: 'Calle Principal 123',
        age: 30,
        profileType: 'Prestación',
        isPhysicalPerson: true,
        isNonPhysicalPerson: false,
        requestedProfessions: ['Mecánico'],
        contractionType: 'Permanente',
        rating: 4.5,
        isBlocked: false,
        isAvailable: true,
        hasAgreedToConfidentiality: true,
      ));
    } else {
      print('Credenciales inválidas en el repositorio');
      return Left(AuthFailure(
        message: 'Credenciales inválidas',
        statusCode: 401,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, bool>> register(String name, String lastName, String email, String username, String password) async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String token, String newPassword) async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(UserModel user) async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> verifyEmail(String token) async {
    return const Right(true);
  }
}

// Clase para observar los eventos del BLoC
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Bloc: ${bloc.runtimeType}, Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Bloc: ${bloc.runtimeType}, Transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('Bloc: ${bloc.runtimeType}, Error: $error');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar el observador de BLoC
  Bloc.observer = SimpleBlocObserver();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Crear el repositorio mock
  final mockRepository = MockAuthRepository();
  
  // Crear los casos de uso
  final checkAuthStatus = CheckAuthStatus(mockRepository);
  final login = Login(mockRepository);
  final logout = Logout(mockRepository);
  final register = Register(mockRepository);
  final googleLogin = GoogleLogin(mockRepository);
  final verifyEmail = VerifyEmail(mockRepository);
  final forgotPassword = ForgotPassword(mockRepository);
  final resetPassword = ResetPassword(mockRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            checkAuthStatus: checkAuthStatus,
            login: login,
            logout: logout,
            register: register,
            googleLogin: googleLogin,
            verifyEmail: verifyEmail,
            forgotPassword: forgotPassword,
            resetPassword: resetPassword,
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => JobProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Bolsa de Trabajo LR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}

