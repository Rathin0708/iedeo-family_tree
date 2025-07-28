import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../../core/di/injection_container.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';
import 'mvvm_signup_screen.dart';

class MVVMLoginScreen extends StatefulWidget {
  const MVVMLoginScreen({super.key});

  @override
  State<MVVMLoginScreen> createState() => _MVVMLoginScreenState();
}

class _MVVMLoginScreenState extends State<MVVMLoginScreen> {
  late LoginViewModel _viewModel;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = InjectionContainer.loginViewModel;
    
    // Listen to ViewModel changes
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
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
    return Column(
      children: [
        CustomTextField(
          label: AppStrings.email,
          hintText: 'Enter your email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          errorText: _viewModel.emailError,
          onChanged: (value) {
            _viewModel.updateEmail(value);
          },
        ),
        const SizedBox(height: 24),
        CustomTextField(
          label: AppStrings.password,
          hintText: 'Enter your password',
          controller: _passwordController,
          obscureText: _viewModel.obscurePassword,
          errorText: _viewModel.passwordError,
          suffixIcon: IconButton(
            icon: Icon(
              _viewModel.obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              _viewModel.togglePasswordVisibility();
            },
          ),
          onChanged: (value) {
            _viewModel.updatePassword(value);
          },
        ),
      ],
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return LoadingButton(
          text: AppStrings.login,
          isLoading: authState is AuthLoading,
          isEnabled: _viewModel.isFormValid,
          onPressed: () {
            _viewModel.login();
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
                builder: (context) => const MVVMSignupScreen(),
              ),
            );
          },
          child: const Text(AppStrings.signUpHere),
        ),
      ],
    );
  }
}
