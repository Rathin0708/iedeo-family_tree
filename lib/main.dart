import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/auth/auth_state.dart';
import 'presentation/screens/mvvm_login_screen.dart';
import 'presentation/screens/mvvm_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InjectionContainer.init();
  runApp(const FamilyTreeApp());
}

class FamilyTreeApp extends StatelessWidget {
  const FamilyTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: InjectionContainer.authBloc..add(AuthCheckRequested()),
      child: MaterialApp(
        title: 'Family Tree',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthLoading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case AuthAuthenticated:
            return const MVVMHomeScreen();
          case AuthUnauthenticated:
          case AuthError:
            return const MVVMLoginScreen();
          default:
            return const MVVMLoginScreen();
        }
      },
    );
  }
}
