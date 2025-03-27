import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';

abstract class AuthService {
  Future<String?> getToken();
  Future<bool> refreshToken();
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String refreshToken);
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> logout();
  Future<bool> isLoggedIn();
}

class AuthServiceImpl implements AuthService {
  final LocalStorageService _localStorageService;
  
  AuthServiceImpl(this._localStorageService);
  
  @override
  Future<String?> getToken() async {
    return await _localStorageService.getSecure('token');
  }
  
  @override
  Future<bool> refreshToken() async {
    final refreshToken = await _localStorageService.getSecure('refresh_token');
    
    if (refreshToken == null) {
      return false;
    }
    
    // In a real app, you would make an API call to refresh the token
    // For now, we'll simulate a successful refresh
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate a new token
    await _localStorageService.saveSecure('token', 'new_token_${DateTime.now().millisecondsSinceEpoch}');
    
    return true;
  }
  
  @override
  Future<void> saveToken(String token) async {
    await _localStorageService.saveSecure('token', token);
  }
  
  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _localStorageService.saveSecure('refresh_token', refreshToken);
  }
  
  @override
  Future<void> saveUser(UserModel user) async {
    await _localStorageService.save('user', user.toJson());
  }
  
  @override
  Future<UserModel?> getUser() async {
    final userJson = await _localStorageService.get<Map<String, dynamic>>('user');
    
    if (userJson == null) {
      return null;
    }
    
    return UserModel.fromJson(userJson);
  }
  
  @override
  Future<void> logout() async {
    await _localStorageService.removeSecure('token');
    await _localStorageService.removeSecure('refresh_token');
    await _localStorageService.remove('user');
  }
  
  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}

