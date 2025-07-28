import 'package:formz/formz.dart';

// Email validation
enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) return EmailValidationError.empty;
    return _emailRegExp.hasMatch(value!) ? null : EmailValidationError.invalid;
  }
}

// Password validation
enum PasswordValidationError { empty, tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) return PasswordValidationError.empty;
    return value!.length >= 6 ? null : PasswordValidationError.tooShort;
  }
}

// Confirm Password validation
enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;
  
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''}) : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) return ConfirmPasswordValidationError.empty;
    return value == password ? null : ConfirmPasswordValidationError.mismatch;
  }
}

// Full Name validation
enum FullNameValidationError { empty }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([super.value = '']) : super.dirty();

  @override
  FullNameValidationError? validator(String? value) {
    return (value?.isEmpty ?? true) ? FullNameValidationError.empty : null;
  }
}
