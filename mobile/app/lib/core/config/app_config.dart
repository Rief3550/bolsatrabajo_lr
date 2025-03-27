import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment {
  dev,
  staging,
  prod,
}

class AppConfig {
  static late Environment _environment;
  static late String _apiBaseUrl;
  static late bool _enableLogging;
  static late bool _enableCrashlytics;
  static late bool _enableAnalytics;
  
  static Environment get environment => _environment;
  static String get apiBaseUrl => _apiBaseUrl;
  static bool get enableLogging => _enableLogging;
  static bool get enableCrashlytics => _enableCrashlytics;
  static bool get enableAnalytics => _enableAnalytics;
  
  static Future<void> init(Environment env) async {
    _environment = env;
    
    await dotenv.load(fileName: _getEnvFileName());
    
    _apiBaseUrl = dotenv.env['API_BASE_URL'] ?? 'https://api.bolsatrabajoLR.com';
    _enableLogging = dotenv.env['ENABLE_LOGGING'] == 'true';
    _enableCrashlytics = dotenv.env['ENABLE_CRASHLYTICS'] == 'true';
    _enableAnalytics = dotenv.env['ENABLE_ANALYTICS'] == 'true';
  }
  
  static String _getEnvFileName() {
    switch (_environment) {
      case Environment.dev:
        return 'assets/env/.env.dev';
      case Environment.staging:
        return 'assets/env/.env.staging';
      case Environment.prod:
        return 'assets/env/.env.prod';
    }
  }
}

