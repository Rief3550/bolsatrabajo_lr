abstract class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});
  Future<void> setUserProperties({required String userId, Map<String, dynamic>? properties});
  Future<void> logScreenView(String screenName);
  Future<void> logLogin({String? method});
  Future<void> logSignUp({String? method});
}

class AnalyticsServiceImpl implements AnalyticsService {
  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    // Implementación real conectaría con Firebase Analytics u otro servicio
    print('Analytics Event: $name, Parameters: $parameters');
  }

  @override
  Future<void> setUserProperties({required String userId, Map<String, dynamic>? properties}) async {
    print('Set User Properties: $userId, Properties: $properties');
  }

  @override
  Future<void> logScreenView(String screenName) async {
    print('Screen View: $screenName');
  }

  @override
  Future<void> logLogin({String? method}) async {
    print('Login Event: $method');
  }

  @override
  Future<void> logSignUp({String? method}) async {
    print('Sign Up Event: $method');
  }
}

