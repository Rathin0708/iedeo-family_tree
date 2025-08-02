import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/repositories/auth_repository.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/viewmodels/login_viewmodel.dart';
import '../../presentation/viewmodels/signup_viewmodel.dart';
import '../../presentation/viewmodels/home_viewmodel.dart';
import '../../presentation/viewmodels/splash_viewmodel.dart';

class InjectionContainer {
  static late http.Client _httpClient;
  static late FlutterSecureStorage _secureStorage;
  static late AuthRepository _authRepository;
  static late AuthBloc _authBloc;
  static late LoginViewModel _loginViewModel;
  static late SignupViewModel _signupViewModel;
  static late HomeViewModel _homeViewModel;
  static late SplashViewModel _splashViewModel;

  static void init() {
    // External dependencies
    _httpClient = http.Client();
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    // Repository
    _authRepository = AuthRepositoryImpl(
      httpClient: _httpClient,
      secureStorage: _secureStorage,
    );

    // BLoC
    _authBloc = AuthBloc(authRepository: _authRepository);

    // ViewModels
    _loginViewModel = LoginViewModel(
      authRepository: _authRepository,
      authBloc: _authBloc,
    );
    _signupViewModel = SignupViewModel(
      authRepository: _authRepository,
      authBloc: _authBloc,
    );
    _homeViewModel = HomeViewModel(
      authRepository: _authRepository,
      authBloc: _authBloc,
    );
    _splashViewModel = SplashViewModel(
      authRepository: _authRepository,
    );
  }

  // Getters
  static http.Client get httpClient => _httpClient;
  static FlutterSecureStorage get secureStorage => _secureStorage;
  static AuthRepository get authRepository => _authRepository;
  static AuthBloc get authBloc => _authBloc;
  static LoginViewModel get loginViewModel => _loginViewModel;
  static SignupViewModel get signupViewModel => _signupViewModel;
  static HomeViewModel get homeViewModel => _homeViewModel;
  static SplashViewModel get splashViewModel => _splashViewModel;

  static void dispose() {
    _httpClient.close();
    _authBloc.close();
  }
}
