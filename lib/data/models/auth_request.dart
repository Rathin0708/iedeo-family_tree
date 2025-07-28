import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [email, password];
}

class SignupRequest extends Equatable {
  final String email;
  final String password;
  final String fullName;

  const SignupRequest({
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }

  @override
  List<Object> get props => [email, password, fullName];
}
