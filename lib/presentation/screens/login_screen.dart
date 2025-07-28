import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authBloc: context.read<AuthBloc>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
              // Reset form status
              context.read<LoginBloc>().add(
                    LoginEmailChanged(_emailController.text),
                  );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                _buildHeader(context),
                const SizedBox(height: 48),
                _buildLoginForm(context),
                const SizedBox(height: 24),
                _buildForgotPassword(context),
                const SizedBox(height: 32),
                _buildLoginButton(context),
                const SizedBox(height: 32),
                _buildSignupLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to your account to continue',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              label: AppStrings.email,
              hintText: 'Enter your email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              errorText: _getEmailErrorText(state.email),
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginEmailChanged(value));
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: AppStrings.password,
              hintText: 'Enter your password',
              controller: _passwordController,
              obscureText: _obscurePassword,
              errorText: _getPasswordErrorText(state.password),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginPasswordChanged(value));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: const Text(AppStrings.forgotPassword),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return LoadingButton(
              text: AppStrings.login,
              isLoading: authState is AuthLoading,
              isEnabled: state.isValid,
              onPressed: () {
                context.read<LoginBloc>().add(LoginSubmitted());
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSignupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignupScreen(),
              ),
            );
          },
          child: const Text(AppStrings.signUpHere),
        ),
      ],
    );
  }

  String? _getEmailErrorText(Email email) {
    if (email.isPure) return null;
    
    switch (email.error) {
      case EmailValidationError.empty:
        return AppStrings.emailRequired;
      case EmailValidationError.invalid:
        return AppStrings.emailInvalid;
      case null:
        return null;
    }
  }

  String? _getPasswordErrorText(Password password) {
    if (password.isPure) return null;
    
    switch (password.error) {
      case PasswordValidationError.empty:
        return AppStrings.passwordRequired;
      case PasswordValidationError.tooShort:
        return AppStrings.passwordTooShort;
      case null:
        return null;
    }
  }
}
