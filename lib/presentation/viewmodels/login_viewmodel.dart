import 'package:flutter/foundation.dart';
import '../../core/utils/validators.dart';
import '../../data/models/auth_request.dart';
import '../../data/repositories/auth_repository.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthBloc _authBloc;

  LoginViewModel({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  }) : _authBloc = authBloc;

  // Form fields
  Email _email = const Email.pure();
  Password _password = const Password.pure();
  
  // UI state
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;

  // Getters
  Email get email => _email;
  Password get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get obscurePassword => _obscurePassword;
  bool get isFormValid => _email.isValid && _password.isValid;

  // Email field methods
  void updateEmail(String value) {
    _email = Email.dirty(value);
    _clearError();
    notifyListeners();
  }

  String? get emailError {
    if (_email.isPure) return null;
    switch (_email.error) {
      case EmailValidationError.empty:
        return 'Email is required';
      case EmailValidationError.invalid:
        return 'Please enter a valid email';
      case null:
        return null;
    }
  }

  // Password field methods
  void updatePassword(String value) {
    _password = Password.dirty(value);
    _clearError();
    notifyListeners();
  }

  String? get passwordError {
    if (_password.isPure) return null;
    switch (_password.error) {
      case PasswordValidationError.empty:
        return 'Password is required';
      case PasswordValidationError.tooShort:
        return 'Password must be at least 6 characters';
      case null:
        return null;
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Clear error message
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
    }
  }

  // Login action
  Future<void> login() async {
    if (!isFormValid) return;

    _setLoading(true);
    _clearError();

    try {
      final request = LoginRequest(
        email: _email.value,
        password: _password.value,
      );

      // Use AuthBloc for authentication
      _authBloc.add(AuthLoginRequested(request));
    } catch (e) {
      _setError('Login failed. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Reset form
  void resetForm() {
    _email = const Email.pure();
    _password = const Password.pure();
    _isLoading = false;
    _errorMessage = null;
    _obscurePassword = true;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
