import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/config/app_config.dart';
import 'package:flutter_job_marketplace/core/di/service_locator.dart';
import 'package:flutter_job_marketplace/core/services/navigation_service.dart';
import 'package:flutter_job_marketplace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_job_marketplace/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_job_marketplace/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:flutter_job_marketplace/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:flutter_job_marketplace/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_job_marketplace/features/services/presentation/bloc/service_bloc.dart';
import 'package:flutter_job_marketplace/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
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
  
  // Initialize app configuration
  await AppConfig.init(Environment.dev);
  
  // Initialize service locator
  await initServiceLocator();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<JobBloc>(
          create: (_) => sl<JobBloc>(),
        ),
        BlocProvider<NotificationBloc>(
          create: (_) => sl<NotificationBloc>()..add(GetNotificationsEvent()),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => sl<ProfileBloc>(),
        ),
        BlocProvider<ServiceBloc>(
          create: (_) => sl<ServiceBloc>(),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => sl<ChatBloc>(),
        ),
        BlocProvider<SettingsBloc>(
          create: (_) => sl<SettingsBloc>()..add(GetSettingsEvent()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final themeMode = state is SettingsLoaded
              ? state.settings.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light
              : ThemeMode.light;
          
          return MaterialApp(
            title: 'Bolsa de Trabajo LR',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
            navigatorKey: sl<NavigationService>().navigatorKey,
          );
        },
      ),
    );
  }
}

