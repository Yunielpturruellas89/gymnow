import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gymnow/core/models/user.dart';
import 'package:gymnow/core/services/secure_storage_service.dart';
import 'package:gymnow/core/utils/app_constants.dart';

class ApiService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${AppConstants.apiUrl}/login'), // Ensure apiUrl is defined
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  Future<User> getUserInfo() async {
    final token = await _secureStorageService.getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('${AppConstants.apiUrl}/user'), // Endpoint to get user info
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get user info: ${response.statusCode}');
    }
  }
}
