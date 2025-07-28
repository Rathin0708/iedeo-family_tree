import 'package:flutter/foundation.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  HomeViewModel({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authRepository = authRepository,
        _authBloc = authBloc {
    // Listen to AuthBloc state changes
    _authBloc.stream.listen((state) {
      if (state is AuthAuthenticated) {
        _user = state.user;
        notifyListeners();
      } else if (state is AuthUnauthenticated) {
        _user = null;
        notifyListeners();
      }
    });
  }

  // User data
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  // User display methods
  String get userInitials {
    if (_user?.fullName.isNotEmpty == true) {
      final names = _user!.fullName.split(' ');
      if (names.length >= 2) {
        return '${names[0][0]}${names[1][0]}'.toUpperCase();
      }
      return _user!.fullName[0].toUpperCase();
    }
    return 'U';
  }

  String get welcomeMessage {
    if (_user?.fullName.isNotEmpty == true) {
      return 'Welcome, ${_user!.fullName}!';
    }
    return 'Welcome!';
  }

  String get userEmail => _user?.email ?? '';

  // Actions
  Future<void> logout() async {
    _setLoading(true);
    _clearError();

    try {
      _authBloc.add(AuthLogoutRequested());
    } catch (e) {
      _setError('Failed to logout. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshUserData() async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to refresh user data.');
    } finally {
      _setLoading(false);
    }
  }

  // Navigation actions
  void navigateToFamilyTree() {
    // TODO: Implement family tree navigation
    _setError('Family tree feature coming soon!');
  }

  void navigateToProfile() {
    // TODO: Implement profile navigation
    _setError('Profile feature coming soon!');
  }

  void navigateToSettings() {
    // TODO: Implement settings navigation
    _setError('Settings feature coming soon!');
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

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  void clearError() {
    _clearError();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
