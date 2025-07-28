import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../models/auth_request.dart';
import '../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<UserModel> login(LoginRequest request);
  Future<UserModel> signup(SignupRequest request);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<bool> isLoggedIn();
}

class AuthRepositoryImpl implements AuthRepository {
  final http.Client httpClient;
  final FlutterSecureStorage secureStorage;
  
  // Mock API base URL - replace with your actual API
  static const String baseUrl = 'https://api.example.com';
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  AuthRepositoryImpl({
    required this.httpClient,
    required this.secureStorage,
  });

  @override
  Future<UserModel> login(LoginRequest request) async {
    try {
      // Mock implementation - replace with actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      // Mock successful login
      if (request.email == 'test@example.com' && request.password == 'password') {
        final mockUser = UserModel(
          id: '1',
          email: 'test@example.com',
          fullName: 'Test User',
          createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        );
        
        // Store token and user data
        await secureStorage.write(key: tokenKey, value: 'mock_token_123');
        await secureStorage.write(key: userKey, value: jsonEncode(mockUser.toJson()));
        
        return mockUser;
      } else {
        throw const AuthFailure('Invalid email or password');
      }
      
      /* Actual API implementation would look like this:
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['user']);
        
        // Store token and user data
        await secureStorage.write(key: tokenKey, value: data['token']);
        await secureStorage.write(key: userKey, value: jsonEncode(user.toJson()));
        
        return user;
      } else {
        throw AuthFailure('Login failed: ${response.body}');
      }
      */
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw NetworkFailure('Network error occurred during login');
    }
  }

  @override
  Future<UserModel> signup(SignupRequest request) async {
    try {
      // Mock implementation - replace with actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      // Mock successful signup
      final mockUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: request.email,
        fullName: request.fullName,
        createdAt: DateTime.now(),
      );
      
      // Store token and user data
      await secureStorage.write(key: tokenKey, value: 'mock_token_${mockUser.id}');
      await secureStorage.write(key: userKey, value: jsonEncode(mockUser.toJson()));
      
      return mockUser;
      
      /* Actual API implementation would look like this:
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['user']);
        
        // Store token and user data
        await secureStorage.write(key: tokenKey, value: data['token']);
        await secureStorage.write(key: userKey, value: jsonEncode(user.toJson()));
        
        return user;
      } else {
        throw AuthFailure('Signup failed: ${response.body}');
      }
      */
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw NetworkFailure('Network error occurred during signup');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await secureStorage.delete(key: tokenKey);
      await secureStorage.delete(key: userKey);
    } catch (e) {
      throw const UnknownFailure('Failed to logout');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = await secureStorage.read(key: userKey);
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        return UserModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await secureStorage.read(key: tokenKey);
      return token != null;
    } catch (e) {
      return false;
    }
  }
}
