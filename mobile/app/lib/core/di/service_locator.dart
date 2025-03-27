import 'package:flutter_job_marketplace/core/api/api_client.dart';
import 'package:flutter_job_marketplace/core/api/api_interceptor.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/core/services/analytics_service.dart';
import 'package:flutter_job_marketplace/core/services/auth_service.dart';
import 'package:flutter_job_marketplace/core/services/connectivity_service.dart';
import 'package:flutter_job_marketplace/core/services/device_info_service.dart';
import 'package:flutter_job_marketplace/core/services/logger_service.dart';
import 'package:flutter_job_marketplace/core/services/navigation_service.dart';
import 'package:flutter_job_marketplace/core/services/notification_service.dart';
import 'package:flutter_job_marketplace/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/check_auth_status.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/login.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/logout.dart';
import 'package:flutter_job_marketplace/features/auth/domain/usecases/register.dart';
import 'package:flutter_job_marketplace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_job_marketplace/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_job_marketplace/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_job_marketplace/features/chat/domain/usecases/get_chat_list.dart';
import 'package:flutter_job_marketplace/features/chat/domain/usecases/get_messages.dart';
import 'package:flutter_job_marketplace/features/chat/domain/usecases/send_message.dart';
import 'package:flutter_job_marketplace/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_job_marketplace/features/jobs/data/repositories/job_repository_impl.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/create_job.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/delete_job.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/get_job_by_id.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/get_jobs.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/update_job.dart';
import 'package:flutter_job_marketplace/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:flutter_job_marketplace/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/usecases/get_notifications.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/usecases/mark_all_as_read.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/usecases/mark_as_read.dart';
import 'package:flutter_job_marketplace/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:flutter_job_marketplace/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_job_marketplace/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_job_marketplace/features/profile/domain/usecases/get_profile.dart';
import 'package:flutter_job_marketplace/features/profile/domain/usecases/update_profile.dart';
import 'package:flutter_job_marketplace/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_job_marketplace/features/services/data/repositories/service_repository_impl.dart';
import 'package:flutter_job_marketplace/features/services/domain/repositories/service_repository.dart';
import 'package:flutter_job_marketplace/features/services/domain/usecases/get_service_by_id.dart';
import 'package:flutter_job_marketplace/features/services/domain/usecases/get_services.dart';
import 'package:flutter_job_marketplace/features/services/presentation/bloc/service_bloc.dart';
import 'package:flutter_job_marketplace/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_job_marketplace/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_job_marketplace/features/settings/domain/usecases/get_settings.dart';
import 'package:flutter_job_marketplace/features/settings/domain/usecases/update_settings.dart';
import 'package:flutter_job_marketplace/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton(() => ApiInterceptor(sl()));
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageServiceImpl());
  
  // Services
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl(sl()));
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityServiceImpl());
  sl.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());
  sl.registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
  sl.registerLazySingleton<NotificationService>(() => NotificationServiceImpl());
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsServiceImpl());
  sl.registerLazySingleton<DeviceInfoService>(() => DeviceInfoServiceImpl());
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<JobRepository>(() => JobRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(sl()));
  
  // Use cases
  // Auth
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  
  // Jobs
  sl.registerLazySingleton(() => GetJobs(sl()));
  sl.registerLazySingleton(() => GetJobById(sl()));
  sl.registerLazySingleton(() => CreateJob(sl()));
  sl.registerLazySingleton(() => UpdateJob(sl()));
  sl.registerLazySingleton(() => DeleteJob(sl()));
  
  // Notifications
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => MarkAsRead(sl()));
  sl.registerLazySingleton(() => MarkAllAsRead(sl()));
  
  // Profile
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  
  // Services
  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton(() => GetServiceById(sl()));
  
  // Chat
  sl.registerLazySingleton(() => GetChatList(sl()));
  sl.registerLazySingleton(() => GetMessages(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  
  // Settings
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => UpdateSettings(sl()));
  
  // BLoCs
  sl.registerFactory(() => AuthBloc(
    checkAuthStatus: sl(),
    login: sl(),
    logout: sl(),
    register: sl(),
  ));
  
  sl.registerFactory(() => JobBloc(
    getJobs: sl(),
    getJobById: sl(),
    createJob: sl(),
    updateJob: sl(),
    deleteJob: sl(),
  ));
  
  sl.registerFactory(() => NotificationBloc(
    getNotifications: sl(),
    markAsRead: sl(),
    markAllAsRead: sl(),
  ));
  
  sl.registerFactory(() => ProfileBloc(
    getProfile: sl(),
    updateProfile: sl(),
  ));
  
  sl.registerFactory(() => ServiceBloc(
    getServices: sl(),
    getServiceById: sl(),
  ));
  
  sl.registerFactory(() => ChatBloc(
    getChatList: sl(),
    getMessages: sl(),
    sendMessage: sl(),
  ));
  
  sl.registerFactory(() => SettingsBloc(
    getSettings: sl(),
    updateSettings: sl(),
  ));
}

