import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../models/auth_request.dart';
import '../../core/errors/failures.dart';
import '../../core/config/api_config.dart';

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
  
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  AuthRepositoryImpl({
    required this.httpClient,
    required this.secureStorage,
  });

  @override
  Future<UserModel> login(LoginRequest request) async {
    try {
      if (ApiConfig.isMockEnvironment) {
        // Use mock API
        final response = await httpClient.get(
          Uri.parse(ApiConfig.userDataEndpoint),
          headers: ApiConfig.headers,
        ).timeout(ApiConfig.requestTimeout);

        if (response.statusCode == 200) {
          final List<dynamic> users = jsonDecode(response.body);
          
          // Find user with matching email and password
          final userJson = users.firstWhere(
            (user) => user['gmailid'] == request.email && user['password'] == request.password,
            orElse: () => null,
          );
          
          if (userJson != null) {
            final user = UserModel.fromMockApi(userJson);
            
            // Generate mock token
            final token = 'mock_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}';
            
            // Store token and user data
            await secureStorage.write(key: tokenKey, value: token);
            await secureStorage.write(key: userKey, value: jsonEncode(user.toJson()));
            
            return user;
          } else {
            throw const AuthFailure('Invalid email or password');
          }
        } else {
          throw AuthFailure('Login failed: ${response.statusCode}');
        }
      } else {
        // Use production API
        final response = await httpClient.post(
          Uri.parse(ApiConfig.loginEndpoint),
          headers: ApiConfig.headers,
          body: jsonEncode(request.toJson()),
        ).timeout(ApiConfig.requestTimeout);

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
      }
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw NetworkFailure('Network error occurred during login: $e');
    }
  }

  @override
  Future<UserModel> signup(SignupRequest request) async {
    try {
      if (ApiConfig.isMockEnvironment) {
        // Use mock API - Create new user
        final newUser = UserModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: request.email,
          fullName: request.fullName,
          password: request.password,
          createdAt: DateTime.now(),
        );
        
        // Post to mock API
        final response = await httpClient.post(
          Uri.parse(ApiConfig.userDataEndpoint),
          headers: ApiConfig.headers,
          body: jsonEncode(newUser.toMockApiJson()),
        ).timeout(ApiConfig.requestTimeout);

        if (response.statusCode == 201 || response.statusCode == 200) {
          // Generate mock token
          final token = 'mock_token_${newUser.id}_${DateTime.now().millisecondsSinceEpoch}';
          
          // Store token and user data
          await secureStorage.write(key: tokenKey, value: token);
          await secureStorage.write(key: userKey, value: jsonEncode(newUser.toJson()));
          
          return newUser;
        } else {
          throw AuthFailure('Signup failed: ${response.statusCode}');
        }
      } else {
        // Use production API
        final response = await httpClient.post(
          Uri.parse(ApiConfig.signupEndpoint),
          headers: ApiConfig.headers,
          body: jsonEncode(request.toJson()),
        ).timeout(ApiConfig.requestTimeout);

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
      }
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw NetworkFailure('Network error occurred during signup: $e');
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
