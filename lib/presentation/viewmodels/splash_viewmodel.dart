import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';

class SplashViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  
  bool _isLoading = true;
  bool _isAuthenticated = false;
  String _statusMessage = 'Initializing...';

  SplashViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // Getters
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String get statusMessage => _statusMessage;

  /// Initialize the splash screen and check authentication status
  Future<void> initialize() async {
    try {
      _updateStatus('Checking authentication...');
      
      // Add minimum splash duration for better UX
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Check if user is already logged in
      final isLoggedIn = await _authRepository.isLoggedIn();
      
      if (isLoggedIn) {
        _updateStatus('Welcome back!');
        await Future.delayed(const Duration(milliseconds: 500));
        _isAuthenticated = true;
      } else {
        _updateStatus('Ready to start!');
        await Future.delayed(const Duration(milliseconds: 500));
        _isAuthenticated = false;
      }
      
      _isLoading = false;
      notifyListeners();
      
    } catch (e) {
      _updateStatus('Something went wrong...');
      await Future.delayed(const Duration(milliseconds: 1000));
      _isLoading = false;
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  void _updateStatus(String message) {
    _statusMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
