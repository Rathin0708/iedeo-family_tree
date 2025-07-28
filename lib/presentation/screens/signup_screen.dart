import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/signup/signup_bloc.dart';
import '../bloc/signup/signup_event.dart';
import '../bloc/signup/signup_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(
        authBloc: context.read<AuthBloc>(),
      ),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              context.read<SignupBloc>().add(
                    SignupEmailChanged(_emailController.text),
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
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              label: AppStrings.fullName,
              hintText: 'Enter your full name',
              controller: _fullNameController,
              keyboardType: TextInputType.name,
              errorText: _getFullNameErrorText(state.fullName),
              onChanged: (value) {
                context.read<SignupBloc>().add(SignupFullNameChanged(value));
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: AppStrings.email,
              hintText: 'Enter your email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              errorText: _getEmailErrorText(state.email),
              onChanged: (value) {
                context.read<SignupBloc>().add(SignupEmailChanged(value));
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
                context.read<SignupBloc>().add(SignupPasswordChanged(value));
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: AppStrings.confirmPassword,
              hintText: 'Confirm your password',
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              errorText: _getConfirmPasswordErrorText(state.confirmPassword),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              onChanged: (value) {
                context.read<SignupBloc>().add(SignupConfirmPasswordChanged(value));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return LoadingButton(
              text: AppStrings.signup,
              isLoading: authState is AuthLoading,
              isEnabled: state.isValid,
              onPressed: () {
                context.read<SignupBloc>().add(SignupSubmitted());
              },
            );
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
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text(AppStrings.signInHere),
        ),
      ],
    );
  }

  String? _getFullNameErrorText(FullName fullName) {
    if (fullName.isPure) return null;
    
    switch (fullName.error) {
      case FullNameValidationError.empty:
        return AppStrings.fullNameRequired;
      case null:
        return null;
    }
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

  String? _getConfirmPasswordErrorText(ConfirmPassword confirmPassword) {
    if (confirmPassword.isPure) return null;
    
    switch (confirmPassword.error) {
      case ConfirmPasswordValidationError.empty:
        return AppStrings.passwordRequired;
      case ConfirmPasswordValidationError.mismatch:
        return AppStrings.passwordsDoNotMatch;
      case null:
        return null;
    }
  }
}
