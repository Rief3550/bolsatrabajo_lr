import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _currentUser;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId != null) {
        // In a real app, you would fetch user data from a backend
        // For now, we'll create a mock user
        _currentUser = User(
          id: userId,
          username: 'user123',
          password: '',
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
          profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        );
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        _currentUser = null;
      }
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would authenticate with a backend
      // For now, we'll simulate a successful login
      await Future.delayed(const Duration(seconds: 2));

      if (username.isNotEmpty && password.isNotEmpty) {
        _currentUser = User(
          id: '123',
          username: username,
          password: password,
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
          profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        );
        _isAuthenticated = true;

        // Save user ID to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', '123');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String lastName, String email, String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would register with a backend
      // For now, we'll simulate a successful registration
      await Future.delayed(const Duration(seconds: 2));

      if (name.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear user data
      _currentUser = null;
      _isAuthenticated = false;

      // Clear shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(User updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would update user data in a backend
      // For now, we'll just update the local user object
      _currentUser = updatedUser;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

