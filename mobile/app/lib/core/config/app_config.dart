import 'package:flutter/foundation.dart';

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
    
    // En una implementación real, cargaríamos desde un archivo .env
    // Para simplificar, definimos valores por defecto según el entorno
    switch (env) {
      case Environment.dev:
        _apiBaseUrl = 'https://dev-api.bolsatrabajoLR.com';
        _enableLogging = true;
        _enableCrashlytics = false;
        _enableAnalytics = false;
        break;
      case Environment.staging:
        _apiBaseUrl = 'https://staging-api.bolsatrabajoLR.com';
        _enableLogging = true;
        _enableCrashlytics = true;
        _enableAnalytics = true;
        break;
      case Environment.prod:
        _apiBaseUrl = 'https://api.bolsatrabajoLR.com';
        _enableLogging = false;
        _enableCrashlytics = true;
        _enableAnalytics = true;
        break;
    }
  }
}

