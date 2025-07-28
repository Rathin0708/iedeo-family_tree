import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupFullNameChanged extends SignupEvent {
  final String fullName;

  const SignupFullNameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class SignupEmailChanged extends SignupEvent {
  final String email;

  const SignupEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  const SignupPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignupConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;

  const SignupConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignupSubmitted extends SignupEvent {}
