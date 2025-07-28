import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../core/utils/validators.dart';

class SignupState extends Equatable {
  final FullName fullName;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const SignupState({
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  SignupState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        confirmPassword,
        status,
        isValid,
        errorMessage,
      ];
}
