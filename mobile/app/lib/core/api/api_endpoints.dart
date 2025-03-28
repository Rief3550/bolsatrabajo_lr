class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:3000'; // Para emulador Android
  // static const String baseUrl = 'http://localhost:3000'; // Para iOS simulator
  // static const String baseUrl = 'https://tu-dominio.com'; // Para producción

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyEmail = '/auth/verify-email';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh-token';
  static const String googleLogin = '/auth/google';
  
  // Profile endpoints
  static const String profile = '/profile';
  static const String updateProfile = '/profile/update';
  static const String addProfession = '/profile/professions';
  static const String addService = '/profile/services';
  
  // Jobs endpoints
  static const String jobs = '/jobs';
  static const String jobById = '/jobs/'; // Agregar ID al final
  
  // Notifications endpoints
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/mark-read/'; // Agregar ID al final
  static const String markAllAsRead = '/notifications/mark-all-read';
}

