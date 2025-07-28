import 'package:flutter/foundation.dart';
import '../../core/utils/validators.dart';
import '../../data/models/auth_request.dart';
import '../../data/repositories/auth_repository.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthBloc _authBloc;

  SignupViewModel({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  }) : _authBloc = authBloc;

  // Form fields
  FullName _fullName = const FullName.pure();
  Email _email = const Email.pure();
  Password _password = const Password.pure();
  ConfirmPassword _confirmPassword = const ConfirmPassword.pure();
  
  // UI state
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Getters
  FullName get fullName => _fullName;
  Email get email => _email;
  Password get password => _password;
  ConfirmPassword get confirmPassword => _confirmPassword;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get isFormValid => 
      _fullName.isValid && 
      _email.isValid && 
      _password.isValid && 
      _confirmPassword.isValid;

  // Full Name field methods
  void updateFullName(String value) {
    _fullName = FullName.dirty(value);
    _clearError();
    notifyListeners();
  }

  String? get fullNameError {
    if (_fullName.isPure) return null;
    switch (_fullName.error) {
      case FullNameValidationError.empty:
        return 'Full name is required';
      case null:
        return null;
    }
  }

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
    // Update confirm password validation when password changes
    _confirmPassword = ConfirmPassword.dirty(
      password: value,
      value: _confirmPassword.value,
    );
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

  // Confirm Password field methods
  void updateConfirmPassword(String value) {
    _confirmPassword = ConfirmPassword.dirty(
      password: _password.value,
      value: value,
    );
    _clearError();
    notifyListeners();
  }

  String? get confirmPasswordError {
    if (_confirmPassword.isPure) return null;
    switch (_confirmPassword.error) {
      case ConfirmPasswordValidationError.empty:
        return 'Please confirm your password';
      case ConfirmPasswordValidationError.mismatch:
        return 'Passwords do not match';
      case null:
        return null;
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  // Clear error message
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
    }
  }

  // Signup action
  Future<void> signup() async {
    if (!isFormValid) return;

    _setLoading(true);
    _clearError();

    try {
      final request = SignupRequest(
        fullName: _fullName.value,
        email: _email.value,
        password: _password.value,
      );

      // Use AuthBloc for authentication
      _authBloc.add(AuthSignupRequested(request));
    } catch (e) {
      _setError('Signup failed. Please try again.');
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
    _fullName = const FullName.pure();
    _email = const Email.pure();
    _password = const Password.pure();
    _confirmPassword = const ConfirmPassword.pure();
    _isLoading = false;
    _errorMessage = null;
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
