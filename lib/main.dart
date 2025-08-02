import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/screens/Splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InjectionContainer.init();
  runApp(const FamilyTreeApp());
}

class FamilyTreeApp extends StatelessWidget {
  const FamilyTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // BLoC Provider for authentication
        BlocProvider.value(
          value: InjectionContainer.authBloc,
        ),
        // ViewModel Providers
        ChangeNotifierProvider.value(
          value: InjectionContainer.splashViewModel,
        ),
        ChangeNotifierProvider.value(
          value: InjectionContainer.loginViewModel,
        ),
        ChangeNotifierProvider.value(
          value: InjectionContainer.signupViewModel,
        ),
        ChangeNotifierProvider.value(
          value: InjectionContainer.homeViewModel,
        ),
      ],
      child: MaterialApp(
        title: 'Iedeo Family Tree',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
