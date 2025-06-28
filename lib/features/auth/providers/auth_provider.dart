import 'package:flutter/material.dart';
import 'package:gymnow/core/models/user.dart';
import 'package:gymnow/core/services/api_service.dart';
import 'package:gymnow/core/services/secure_storage_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final SecureStorageService _secureStorageService = SecureStorageService();

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null; // Clear previous errors
    notifyListeners();

    try {
      final response =
          await _apiService.login(email, password); // Changed from LoginRequest
      final token = response['token'];
      await _secureStorageService.setToken(token);
      await loadUser(); // Load the user info after login
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _apiService.getUserInfo();
    } catch (error) {
      _errorMessage = error.toString();
      await _secureStorageService.deleteToken(); // Remove invalid token
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _secureStorageService.deleteToken();
    _user = null;
    notifyListeners();
  }

  Future<bool> hasToken() async {
    final token = await _secureStorageService.getToken();
    return token != null;
  }
}
