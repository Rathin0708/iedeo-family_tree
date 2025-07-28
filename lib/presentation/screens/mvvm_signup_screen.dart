import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../../core/di/injection_container.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../viewmodels/signup_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';
import 'mvvm_login_screen.dart';

class MVVMSignupScreen extends StatefulWidget {
  const MVVMSignupScreen({super.key});

  @override
  State<MVVMSignupScreen> createState() => _MVVMSignupScreenState();
}

class _MVVMSignupScreenState extends State<MVVMSignupScreen> {
  late SignupViewModel _viewModel;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = InjectionContainer.signupViewModel;
    
    // Listen to ViewModel changes
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                _buildSignupForm(context),
                const SizedBox(height: 32),
                _buildSignupButton(context),
                const SizedBox(height: 32),
                _buildLoginLink(context),
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
          'Create Account',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign up to get started with your family tree',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: AppStrings.fullName,
          hintText: 'Enter your full name',
          controller: _fullNameController,
          keyboardType: TextInputType.name,
          errorText: _viewModel.fullNameError,
          onChanged: (value) {
            _viewModel.updateFullName(value);
          },
        ),
        const SizedBox(height: 24),
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
        const SizedBox(height: 24),
        CustomTextField(
          label: AppStrings.confirmPassword,
          hintText: 'Confirm your password',
          controller: _confirmPasswordController,
          obscureText: _viewModel.obscureConfirmPassword,
          errorText: _viewModel.confirmPasswordError,
          suffixIcon: IconButton(
            icon: Icon(
              _viewModel.obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              _viewModel.toggleConfirmPasswordVisibility();
            },
          ),
          onChanged: (value) {
            _viewModel.updateConfirmPassword(value);
          },
        ),
      ],
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return LoadingButton(
          text: AppStrings.signup,
          isLoading: authState is AuthLoading,
          isEnabled: _viewModel.isFormValid,
          onPressed: () {
            _viewModel.signup();
          },
        );
      },
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MVVMLoginScreen(),
              ),
            );
          },
          child: const Text(AppStrings.signInHere),
        ),
      ],
    );
  }
}
