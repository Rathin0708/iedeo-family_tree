import 'package:equatable/equatable.dart';
import '../../../data/models/auth_request.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final LoginRequest request;

  const AuthLoginRequested(this.request);

  @override
  List<Object> get props => [request];
}

class AuthSignupRequested extends AuthEvent {
  final SignupRequest request;

  const AuthSignupRequested(this.request);

  @override
  List<Object> get props => [request];
}

class AuthLogoutRequested extends AuthEvent {}
