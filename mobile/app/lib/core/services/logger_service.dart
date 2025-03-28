enum LogLevel {
  debug,
  info,
  warning,
  error,
}

abstract class LoggerService {
  void debug(String message, {dynamic error, StackTrace? stackTrace});
  void info(String message, {dynamic error, StackTrace? stackTrace});
  void warning(String message, {dynamic error, StackTrace? stackTrace});
  void error(String message, {dynamic error, StackTrace? stackTrace});
}

class LoggerServiceImpl implements LoggerService {
  final LogLevel _minLevel;

  LoggerServiceImpl({LogLevel minLevel = LogLevel.debug}) : _minLevel = minLevel;

  @override
  void debug(String message, {dynamic error, StackTrace? stackTrace}) {
    if (_minLevel.index <= LogLevel.debug.index) {
      print('[DEBUG] $message');
      if (error != null) print('[DEBUG] Error: $error');
      if (stackTrace != null) print('[DEBUG] StackTrace: $stackTrace');
    }
  }

  @override
  void info(String message, {dynamic error, StackTrace? stackTrace}) {
    if (_minLevel.index <= LogLevel.info.index) {
      print('[INFO] $message');
      if (error != null) print('[INFO] Error: $error');
      if (stackTrace != null) print('[INFO] StackTrace: $stackTrace');
    }
  }

  @override
  void warning(String message, {dynamic error, StackTrace? stackTrace}) {
    if (_minLevel.index <= LogLevel.warning.index) {
      print('[WARNING] $message');
      if (error != null) print('[WARNING] Error: $error');
      if (stackTrace != null) print('[WARNING] StackTrace: $stackTrace');
    }
  }

  @override
  void error(String message, {dynamic error, StackTrace? stackTrace}) {
    if (_minLevel.index <= LogLevel.error.index) {
      print('[ERROR] $message');
      if (error != null) print('[ERROR] Error: $error');
      if (stackTrace != null) print('[ERROR] StackTrace: $stackTrace');
    }
  }
}

